#!/bin/bash
#
# Copyright (C) 2021 Encom Enterprise
#
# Script to breakdown OEM kernel source without proper/no commit histories.
#

# Define OEM name:
read -p "Input OEM name: " OEM

# Breakdown
echo "<<< Starting breakdown >>>"
echo ""

	git reset HEAD^ arch/arm64/configs && git commit --amend && git add . && git commit -s -m "ARM64: configs: Import $OEM modifications" && git rebase -i HEAD~2
	git reset HEAD^ drivers/android && git commit --amend && git add . && git commit -s -m "ANDROID: Import $OEM modifications" && git rebase -i HEAD~2
	git reset HEAD^ drivers/block && git commit --amend && git add . && git commit -s -m "block: Import $OEM modifications" && git rebase -i HEAD~2
	git reset HEAD^ drivers/gpu && git commit --amend && git add . && git commit -s -m "gpu: Import $OEM modifications" && git rebase -i HEAD~2
	git reset HEAD^ drivers/input && git commit --amend && git add . && git commit -s -m "input: Import $OEM modifications" && git rebase -i HEAD~2
	git reset HEAD^ drivers/mmc && git commit --amend && git add . && git commit -s -m "mmc: Import $OEM modifications" && git rebase -i HEAD~2
	git reset HEAD^ drivers/usb && git commit --amend && git add . && git commit -s -m "usb: Import $OEM modifications" && git rebase -i HEAD~2
	git reset HEAD^ drivers/power && git commit --amend && git add . && git commit -s -m "power: Import $OEM modifications" && git rebase -i HEAD~2
	git reset HEAD^ drivers && git commit --amend && git add . && git commit -s -m "drivers: Import $OEM modifications" && git rebase -i HEAD~2
	git reset HEAD^ fs && git commit --amend && git add . && git commit -s -m "fs: Import $OEM modifications" && git rebase -i HEAD~2
	git reset HEAD^ include && git commit --amend && git add . && git commit -s -m "include: Import $OEM modifications" && git rebase -i HEAD~2
	git reset HEAD^ kernel && git commit --amend && git add . && git commit -s -m "kernel: Import $OEM modifications" && git rebase -i HEAD~2
	git reset HEAD^ mm && git commit --amend && git add . && git commit -s -m "mm: Import $OEM modifications" && git rebase -i HEAD~2
	git reset HEAD^ net && git commit --amend && git add . && git commit -s -m "net: Import $OEM modifications" && git rebase -i HEAD~2
	git reset HEAD^ sound && git commit --amend && git add . && git commit -s -m "sound: Import $OEM modifications" && git rebase -i HEAD~2
	git reset HEAD^ arch && git commit --amend && git add . && git commit -s -m "arch: Import $OEM modifications" && git rebase -i HEAD~2


echo "Done..."
echo "Now commit remaining sources"
