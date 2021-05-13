# 版本号里显示一个自己的名字（ababwnq build $(TZ=UTC-8 date "+%Y.%m.%d") @ 这些都是后增加的）
rm -rf package/lean/luci-theme-argon
git clone https://github.com/flowlife/luci-theme-argon.git package/lean/luci-theme-argon
sed -i "s/OpenWrt /Compiled by Flowlife $(TZ=UTC-8 date "+%Y.%m.%d") ™ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings
