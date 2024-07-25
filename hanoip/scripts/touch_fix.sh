#!/system/bin/sh

# Set paths
path=/sbin
module_path=$path/modules
firmware_path=$path/firmware
touch_class_path=/sys/class/touchscreen

# Mount vendor and copy necessary files
mount /vendor
cp -r /vendor/lib/modules $path
cp -r /vendor/firmware $path
umount /vendor

# Load kernel modules
insmod $module_path/exfat.ko
insmod $module_path/ilitek_v3_mmi.ko
insmod $module_path/mmi_info.ko
insmod $module_path/moto_f_usbnet.ko
insmod $module_path/qpnp_adaptive_charge.ko
insmod $module_path/sx933x_sar.ko
insmod $module_path/fpc1020_mmi.ko
insmod $module_path/mmi_annotate.ko
insmod $module_path/mmi_sys_temp.ko
insmod $module_path/mpq-adapter.ko
insmod $module_path/sensors_class.ko
insmod $module_path/utags.ko

# Navigate to firmware path
cd $firmware_path

# Retrieve touch product string
touch_product_string=$(ls $touch_class_path)

# Firmware handling
firmware_file="FW_ILITEK_TDDI_TM.bin"
touch_path=/sys$(cat $touch_class_path/$touch_product_string/path | awk '{print $1}')

# Apply the firmware update
wait_for_poweron
echo $firmware_file > $touch_path/doreflash
echo 1 > $touch_path/forcereflash
sleep 5
echo 1 > $touch_path/reset

# Log the process (optional)
echo "Firmware update completed" >> $path/TouchScreenlog.txt
