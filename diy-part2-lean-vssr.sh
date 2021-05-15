rm -rf package/lean/luci-theme-argon
rm -rf package/lean/luci-app-ttyd
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon
sed -i "s/OpenWrt /Compiled by Flowlife $(TZ=UTC-8 date "+%Y.%m.%d") ™ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings
