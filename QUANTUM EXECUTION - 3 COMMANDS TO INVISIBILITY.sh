# 1. DEPLOY QUANTUM SYSTEM
chmod +x deploy_quantum_vpn.sh
sudo ./deploy_quantum_vpn.sh

# 2. RUN QUANTUM VPN
sudo python3 quantum_vpn/core.py

# 3. SCAN QR CODE WITH PHONE
#    - Install WireGuard app
#    - Scan generated QR code
#    - Activate tunnel