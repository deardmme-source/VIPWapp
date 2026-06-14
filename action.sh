#!/system/bin/sh
# VIP Wapp — KSU Action Button (live status)
MODDIR="${0%/*}"
STATUS="$MODDIR/status/module.prop"

get() { grep "^$1=" "$STATUS" 2>/dev/null | cut -d'=' -f2; }

echo ""
echo "╔══════════════════════════════════════╗"
echo "║       VIP WAPP — Live Status         ║"
echo "╚══════════════════════════════════════╝"
echo ""

# Module
VER=$(get module_version)
echo "  📦 Module Version : v$VER"
echo "  📅 Installed      : $(get install_date)"
echo "  📱 Android API    : $(get api_level)"
echo "  🔧 Architecture   : $(get arch)"
echo ""

# WhatsApp
if pm list packages 2>/dev/null | grep -q "com.whatsapp"; then
    echo "  ✅ WhatsApp       : Installed & Ready"
else
    echo "  ❌ WhatsApp       : Not Found"
fi

# VIP Wapp App
if pm list packages 2>/dev/null | grep -q "com.vipwapp"; then
    echo "  ✅ VIP Wapp App   : Installed"
else
    echo "  ❌ VIP Wapp App   : Not Installed"
    echo "     → Download from your GitHub repo"
fi

# Zygisk
if [ -d "/data/adb/modules" ]; then
    echo "  ✅ Zygisk         : Active"
else
    echo "  ⚠️  Zygisk         : Check Magisk/KSU settings"
fi

echo ""
echo "  🕐 Last Boot: $(get last_boot)"
echo ""

# Overall
if pm list packages 2>/dev/null | grep -q "com.whatsapp" && \
   pm list packages 2>/dev/null | grep -q "com.vipwapp"; then
    echo "  🟢 STATUS: FULLY WORKING ✅"
else
    echo "  🟡 STATUS: INSTALL APP FROM REPO"
    echo "     → Get VIP Wapp APK from GitHub"
fi

echo ""
echo "╚══════════════════════════════════════╝"
echo ""
