#!/bin/bash
#
# Usage: ./subtree.sh <tag> <add/pull>
#

function msg() {
  echo -e "\e[1;32m$1\e[0m"
}

  if [[ -z $1 && -z $2 ]]; then
    msg "Usage: subtree <tag> <add/pull>"
    return
  fi

  kernel_version="$( cat Makefile | grep VERSION | head -n 1 | sed "s|.*=||1" | sed "s| ||g" )"
  kernel_patchlevel="$( cat Makefile | grep PATCHLEVEL | head -n 1 | sed "s|.*=||1" | sed "s| ||g" )"
  version=$kernel_version.$kernel_patchlevel
  if [[ $version != "4.14" && $version != "5.4" ]]; then
    msg "Kernel $version not supported! Only msm-5.4 and msm-4.14 are supported as of now."
    return
  fi
  if [[ -z $3 ]]; then
    spec=all
  else
    spec=$3
  fi
  if [[ $2 = "add" ]]; then
  else
    commit_status="Import from"
    tree_status="Updating"
    commit_status="Merge"
    if [[ $spec = "all" ]]; then
      msg "Merging kernel as of $1.."
      git fetch https://source.codeaurora.org/quic/la/kernel/msm-$version $1
      git merge FETCH_HEAD -m "Merge tag '$1' of msm-$version"
    fi
  fi
  if [[ $spec = "wifi" || $spec = "all" ]]; then
    for i in qcacld-3.0 qca-wifi-host-cmn fw-api; do
      msg "$tree_status $i subtree as of $1..."
      git subtree $2 -P drivers/staging/$i -m "$i: $commit_status tag '$1'" \
        https://source.codeaurora.org/quic/la/platform/vendor/qcom-opensource/wlan/$i $1
    done
  fi

  if [[ $spec = "techpack" || $spec = "all" ]]; then
    msg "$tree_status audio-kernel subtree as of $1..."
    git subtree $2 -P techpack/audio -m "techpack: audio: $commit_status tag '$1'" \
      https://source.codeaurora.org/quic/la/platform/vendor/opensource/audio-kernel $1
    if [[ $version = "5.4" ]]; then
      msg "$tree_status camera-kernel subtree as of $1..."
      git subtree $2 -P techpack/camera -m "techpack: camera: $commit_status tag '$1'" \
        https://source.codeaurora.org/quic/la/platform/vendor/opensource/camera-kernel $1
      msg "$tree_status dataipa subtree as of $1..."
      git subtree $2 -P techpack/dataipa -m "techpack: dataipa: $commit_status tag '$1'" \
        https://source.codeaurora.org/quic/la/platform/vendor/opensource/dataipa $1
      msg "$tree_status datarmnet subtree as of $1..."
      git subtree $2 -P techpack/datarmnet -m "techpack: datarmnet: $commit_status tag '$1'" \
        https://source.codeaurora.org/quic/la/platform/vendor/qcom/opensource/datarmnet $1
      msg "$tree_status datarmnet-ext subtree as of $1..."
      git subtree $2 -P techpack/datarmnet-ext -m "techpack: datarmnet-ext: $commit_status tag '$1'" \
        https://source.codeaurora.org/quic/la/platform/vendor/qcom/opensource/datarmnet-ext $1
      msg "$tree_status display-drivers subtree as of $1..."
      git subtree $2 -P techpack/display -m "techpack: display: $commit_status tag '$1'" \
        https://source.codeaurora.org/quic/la/platform/vendor/opensource/display-drivers $1
      msg "$tree_status video-driver subtree as of $1..."
      git subtree $2 -P techpack/video -m "techpack: video: $commit_status tag '$1'" \
        https://source.codeaurora.org/quic/la/platform/vendor/opensource/video-driver $1
    elif [[ $version = "4.14" ]]; then
      if [[ $2 = "add" ]] || [ -d "techpack/data" ]; then
        msg "$tree_status data-kernel as of $1..."
        git subtree $2 -P techpack/data -m "techpack: data: $commit_status tag '$1'"  \
          https://source.codeaurora.org/quic/la/platform/vendor/qcom-opensource/data-kernel $1
      fi
    fi
  fi
