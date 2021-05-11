#!/bin/bash
# https://github.com/Hyy2001X/AutoBuild-Actions
# AutoBuild Module by Hyy2001
# AutoBuild Functions

GET_TARGET_INFO() {
	Diy_Core
	Home="${GITHUB_WORKSPACE}/openwrt"
	[ -f "${GITHUB_WORKSPACE}/Openwrt.info" ] && . ${GITHUB_WORKSPACE}/Openwrt.info
	[[ "${Short_Firmware_Date}" == true ]] && Compile_Date="$(echo ${Compile_Date} | cut -c1-8)"
	User_Repo="$(grep "https://github.com/[a-zA-Z0-9]" ${GITHUB_WORKSPACE}/.git/config | cut -c8-100)"
	[[ -z "${Author}" ]] && {
		Author="$(echo "${User_Repo}" | egrep -o "[a-zA-Z0-9]+" | awk 'NR==4')"
	}
	Openwrt_Repo="$(grep "https://github.com/[a-zA-Z0-9]" ${Home}/.git/config | cut -c8-100)"
	Openwrt_Author="$(echo "${Openwrt_Repo}" | egrep -o "[a-zA-Z0-9]+" | awk 'NR==4')"
	Current_Branch="$(git branch | sed 's/* //g' | sed 's/^[ \t]*//g')"
	In_Firmware_Info=package/base-files/files/etc/openwrt_info
	[[ ! ${Current_Branch} == master ]] && {
		Current_Branch="$(echo ${Current_Branch} | egrep -o "[0-9]+.[0-9]+")"
		Openwrt_Version_="R${Current_Branch}-"
	} || {
		Openwrt_Version_="R18.06-"
	}
	case ${Openwrt_Author} in
	coolsnowwolf)
		Version_File=package/lean/default-settings/files/zzz-default-settings
		Old_Version="$(egrep -o "R[0-9]+\.[0-9]+\.[0-9]+" ${Version_File})"
		Openwrt_Version="${Old_Version}-${Compile_Date}"
	;;
	immortalwrt)
		Version_File=package/base-files/files/etc/openwrt_release
		Openwrt_Version="${Openwrt_Version_}${Compile_Date}"
	;;
	*)
		Openwrt_Version="${Openwrt_Version_}${Compile_Date}"
	;;
	esac
	while [[ -z "${x86_Test}" ]]
	do
		x86_Test="$(egrep -o "CONFIG_TARGET.*DEVICE.*=y" .config | sed -r 's/CONFIG_TARGET_(.*)_DEVICE_(.*)=y/\1/')"
		[[ -n "${x86_Test}" ]] && break
		x86_Test="$(egrep -o "CONFIG_TARGET.*Generic=y" .config | sed -r 's/CONFIG_TARGET_(.*)_Generic=y/\1/')"
		[[ -z "${x86_Test}" ]] && TIME "[ERROR] Can not obtain the TARGET_PROFILE !" && exit 1
	done
	[[ "${x86_Test}" == x86_64 ]] && {
		TARGET_PROFILE="x86_64"
	} || {
		TARGET_PROFILE="$(egrep -o "CONFIG_TARGET.*DEVICE.*=y" .config | sed -r 's/.*DEVICE_(.*)=y/\1/')"
	}
	[[ -z "${TARGET_PROFILE}" ]] && TARGET_PROFILE="${Default_Device}"
	[[ "${TARGET_PROFILE}" == x86_64 ]] && {
		[[ "$(cat ${Home}/.config)" =~ "CONFIG_TARGET_IMAGES_GZIP=y" ]] && {
			Firmware_Type=img.gz
		} || {
			Firmware_Type=img
		}
	}
	TARGET_BOARD="$(awk -F '[="]+' '/TARGET_BOARD/{print $2}' .config)"
	case ${TARGET_BOARD} in
	ramips | reltek | ipq40xx | ath79)
		Firmware_Type=bin
	;;
	rockchip)
		Firmware_Type=img.gz
	;;
	esac
	TARGET_SUBTARGET="$(awk -F '[="]+' '/TARGET_SUBTARGET/{print $2}' .config)"

	echo "Firmware_Type=${Firmware_Type}" > ${Home}/TARGET_INFO
	echo "TARGET_PROFILE=${TARGET_PROFILE}" >> ${Home}/TARGET_INFO
	echo "Openwrt_Version=${Openwrt_Version}" >> ${Home}/TARGET_INFO
	echo "Openwrt_Author=${Openwrt_Author}" >> ${Home}/TARGET_INFO
	echo "TARGET_BOARD=${TARGET_BOARD}" >> ${Home}/TARGET_INFO
	echo "TARGET_SUBTARGET=${TARGET_SUBTARGET}" >> ${Home}/TARGET_INFO
	echo "Home=${Home}" >> ${Home}/TARGET_INFO
	echo "Current_Branch=${Current_Branch}" >> ${Home}/TARGET_INFO

	echo "CURRENT_Version=${Openwrt_Version}" > ${In_Firmware_Info}
	echo "Github=${User_Repo}" >> ${In_Firmware_Info}
	echo "DEFAULT_Device=${TARGET_PROFILE}" >> ${In_Firmware_Info}
	echo "Firmware_Type=${Firmware_Type}" >> ${In_Firmware_Info}

	echo "Author: ${Author}"
	echo "User Repo: ${User_Repo}"
	echo "Firmware Version: ${Openwrt_Version}"
	echo "Firmware Type: ${Firmware_Type}"
	echo "Openwrt Repo: ${Openwrt_Repo}"
	echo "Openwrt Author: ${Openwrt_Author}"
	echo "Openwrt Branch: ${Current_Branch}"
	echo "TARGET_PROFILE: ${TARGET_PROFILE}"
	echo "TARGET_BOARD: ${TARGET_BOARD}"
	echo "TARGET_SUBTARGET: ${TARGET_SUBTARGET}"

	TIME "[Preload Info] All done !"
}
