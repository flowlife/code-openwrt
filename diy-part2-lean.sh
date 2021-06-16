# 版本号里显示一个自己的名字（ababwnq build $(TZ=UTC-8 date "+%Y.%m.%d") @ 这些都是后增加的）
rm -rf package/lean/luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon
sed -i "s/OpenWrt /OpenWrt Compiled by Flowlife $(TZ=UTC-8 date "+%Y.%m.%d") ™/g" package/lean/default-settings/files/zzz-default-settings
