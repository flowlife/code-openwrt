rm -rf package/lean/luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon
sed -i "s/OpenWrt /OpenWrt Compiled by Flowlife $(TZ=UTC-8 date "+%Y.%m.%d") ™/g" package/lean/default-settings/files/zzz-default-settings
