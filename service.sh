#!/system/bin/sh
# VIP Wapp — Boot Service
MODDIR="${0%/*}"
STATUS="$MODDIR/status/module.prop"
LOG="$MODDIR/status/service.log"

log() { echo "[$(date '+%H:%M:%S')] $1" >> "$LOG"; }

sleep 15
log "VIP Wapp service started"

# Check WhatsApp
WA_OK=false
for pkg in com.whatsapp com.whatsapp.w4b; do
    if pm list packages 2>/dev/null | grep -q "^package:${pkg}$"; then
        WA_OK=true
        log "WhatsApp OK: $pkg"
    fi
done

# Check VIP Wapp app installed
APP_OK=false
if pm list packages 2>/dev/null | grep -q "^package:com.vipwapp$"; then
    APP_OK=true
    log "VIP Wapp app: installed"
else
    log "VIP Wapp app: not installed"
fi

# Update status
sed -i "s/^wa_found=.*/wa_found=$WA_OK/" "$STATUS" 2>/dev/null
sed -i "s/^status=.*/status=running/" "$STATUS" 2>/dev/null
echo "app_installed=$APP_OK" >> "$STATUS"
echo "last_boot=$(date '+%Y-%m-%d %H:%M')" >> "$STATUS"

log "Service complete — WA:$WA_OK APP:$APP_OK"
