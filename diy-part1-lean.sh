#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
git clone https://github.com/kenzok8/openwrt-packages.git package/openwrt-packages
git clone https://github.com/kenzok8/small.git package/small
git other OpenClash https://github.com/vernesong master
git other luci-app-usb3disable https://github.com/rufengsuixing
svn other luci-app-eqos https://github.com/kenzok8/openwrt-packages/trunk
git other luci-app-bearDropper https://github.com/NateLol
svn package/kernel mt76 https://github.com/openwrt/openwrt/trunk/package/kernel
git other luci-app-argon-config https://github.com/jerrykuku
git other luci-app-adguardhome https://github.com/Hyy2001X
svn other luci-app-smartdns https://github.com/kenzok8/openwrt-packages/trunk
svn ../feeds/packages/net smartdns https://github.com/kenzok8/openwrt-packages/trunk
git other luci-app-serverchan https://github.com/tty228
svn other luci-app-socat https://github.com/Lienol/openwrt-package/trunk
git other luci-app-onliner https://github.com/rufengsuixing

#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default
# Add a feed source
#sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default
