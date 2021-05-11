sed -i "s/OpenWrt /Flowlife/g" package/lean/default-settings/files/zzz-default-settings
rm -rf package/lean/luci-theme-argon
git clone https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon
