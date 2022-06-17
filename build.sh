#/bin/bash
UBOOT_DIR="u-boot-2020.07"

#说明：当前目录为 /home/f1c200s/u-boot-2020.07/u-boot-2020.07
DIR=$(cd $(dirname $0) && pwd )

printf_info(){
	local BN=`basename $1`
	echo "							              "
	echo "****************************************************************"
	echo "Please input target                                             "
	echo "Usage:							      "
	echo "	$BN <licheepi|mangopi>                                        "
	echo "explain:                                                        "
	echo "    licheepi  : compile licheepi u-boot-sunxi-with-spl.bin      "
	echo "    mangopi   : compile mangopi u-boot-sunxi-with-spl.bin       "
	echo "****************************************************************"
	echo "								      "
}

build_licheepi()
{
	cd ${DIR}/$UBOOT_DIR
	make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- licheepi_nano_spiflash_defconfig
	make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- -j8
}

build_mangopi()
{
	cd ${DIR}/$UBOOT_DIR
	make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- mangopi_r3_spiflash_defconfig
	make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- -j8
}


build_select_compile()
{
	case ${Para1} in
	licheepi)
		echo ===================build:$@====================
		build_licheepi
		;;	
	mangopi)
		echo ===================build:$@====================
		build_mangopi
		;;
	*)
		printf_info $0
		;;
    esac
}

#-----------------------------main---------------------------------


Para1=$1

build_select_compile

#------------------------------------------------------------------

