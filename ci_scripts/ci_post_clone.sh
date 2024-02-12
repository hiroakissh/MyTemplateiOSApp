#!/bin/bash
# ref-1: https://developer.apple.com/documentation/Xcode-Release-Notes/xcode-13_3-release-notes#Build-System
# ref-2: https://forums.swift.org/t/telling-xcode-14-beta-4-to-trust-build-tool-plugins-programatically/59305/7
defaults write com.apple.dt.Xcode IDESkipPackagePluginFingerprintValidatation -bool true
