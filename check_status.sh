#!/bin/bash
# Safwaan-proxy Installation Status Checker

echo "🔍 Safwaan-proxy Status..."
echo "Xray: $(systemctl is-active xray)"
echo "WireGuard: $(systemctl is-active wg-quick@wg0)"
echo ""
echo "📡 LISTENING PORTS:"
netstat -tulpn | grep -E '(:80|:443|:993|:51820)' | grep LISTEN
echo ""
echo "📊 XRAY LOGS (last 5 lines):"
tail -5 /var/log/xray/access.log 2>/dev/null || echo "No logs yet"
echo ""
echo "🌐 SERVER IP: $(curl -s ifconfig.me)"