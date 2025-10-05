#!/bin/bash
# Safwaan-proxy Firewall & Service Setup
echo "🔥 Safwaan-proxy: Setting up firewall..."
echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf
sysctl -p
ufw allow ssh
ufw allow 80/tcp
ufw allow 443/tcp  
ufw allow 993/tcp
ufw allow 51820/udp
ufw --force enable
# Start Xray
systemctl enable xray
systemctl start xray
# Setup WireGuard (server key)
wg_server_private=$(wg genkey)
echo "$wg_server_private" > /etc/wireguard/private.key
wg_server_public=$(echo "$wg_server_private" | wg pubkey)
cat > /etc/wireguard/wg0.conf << WGEOF
[Interface]
PrivateKey = $wg_server_private
Address = 10.99.0.1/24
ListenPort = 51820
PostUp = iptables -A FORWARD -i wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
PostDown = iptables -D FORWARD -i wg0 -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE

[Peer]
PublicKey = $wg_server_public
AllowedIPs = 10.99.0.2/32
WGEOF
systemctl enable wg-quick@wg0
systemctl start wg-quick@wg0
echo "✅ Firewall & services configured!"