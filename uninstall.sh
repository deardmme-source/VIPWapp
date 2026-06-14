#!/system/bin/sh
# VIP Wapp — Uninstaller
pm uninstall com.vipwapp >/dev/null 2>&1
rm -rf /data/data/com.vipwapp 2>/dev/null
echo "VIP Wapp removed. Please reboot."
