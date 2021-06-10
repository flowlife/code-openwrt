git clone https://github.com/kenzok8/openwrt-packages.git package/openwrt-packages
git clone https://github.com/kenzok8/small.git package/small
git clone https://github.com/flowlife/luci-app-onliner.git package/luci-app-onliner
sed -i 's/src-git packages https:\/\/github.com\/coolsnowwolf\/packages/src-git packages https:\/\/github.com\/flowlife\/packages/g' feeds.conf.default
