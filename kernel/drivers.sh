#!/bin/bash
#
# Usage: ./subtree.sh <tag> <add/pull>
#

function msg() {
  echo -e "\e[1;32m$1\e[0m"
}

  if [[ -z "$1" && -z "$2" ]]; then
    msg "Usage: subtree <tag> <add/pull>"
    return
  fi

  if [[ $2 == "add" ]]; then
    tree_status="Adding"
  else
    tree_status="Updating"
  fi

  msg "$tree_status audio-kernel subtree as of $1..."
  git subtree $2 -P techpack/audio \
    https://source.codeaurora.org/quic/la/platform/vendor/opensource/audio-kernel "$1"
  msg "$tree_status camera-kernel subtree as of $1..."
  git subtree $2 -P techpack/camera \
    https://source.codeaurora.org/quic/la/platform/vendor/opensource/camera-kernel "$1"
  msg "$tree_status data-kernel subtree as of $1..."
  git subtree $2 -P techpack/data \
    https://source.codeaurora.org/quic/la/platform/vendor/qcom-opensource/data-kernel "$1"
  msg "$tree_status dataipa subtree as of $1..."
  git subtree $2 -P techpack/dataipa \
    https://source.codeaurora.org/quic/la/platform/vendor/opensource/dataipa "$1"
  msg "$tree_status datarmnet subtree as of $1..."
  git subtree $2 -P techpack/datarmnet \
    https://source.codeaurora.org/quic/la/platform/vendor/qcom/opensource/datarmnet "$1"
  msg "$tree_status datarmnet-ext subtree as of $1..."
  git subtree $2 -P techpack/datarmnet-ext \
    https://source.codeaurora.org/quic/la/platform/vendor/qcom/opensource/datarmnet-ext "$1"
  msg "$tree_status display-drivers subtree as of $1..."
  git subtree $2 -P techpack/display \
    https://source.codeaurora.org/quic/la/platform/vendor/opensource/display-drivers "$1"
  msg "$tree_status video-driver subtree as of $1..."
  git subtree $2 -P techpack/video \
    https://source.codeaurora.org/quic/la/platform/vendor/opensource/video-driver "$1"
  msg "$tree_status qcacld-3.0 subtree from as of $1 ..."
  git subtree $2 -P drivers/staging/qcacld-3.0 \
    https://source.codeaurora.org/quic/la/platform/vendor/qcom-opensource/wlan/qcacld-3.0 "$1"
  msg "$tree_status qca-wifi-host-cmn subtree as of $1..."
  git subtree $2 -P drivers/staging/qca-wifi-host-cmn \
    https://source.codeaurora.org/quic/la/platform/vendor/qcom-opensource/wlan/qca-wifi-host-cmn "$1"
  msg "$tree_status fw-api subtree as of $1..."
  git subtree $2 -P drivers/staging/fw-api \
    https://source.codeaurora.org/quic/la/platform/vendor/qcom-opensource/wlan/fw-api "$1"
