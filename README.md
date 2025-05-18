vpn-guardian.sh
Version: 1.0 
Author: gatopedia License: MIT
Overview
vpn-guardian.sh is a simple and lightweight VPN monitoring script designed for routers with a single VPN tunnel (WireGuard or OpenVPN). It notifies you via Telegram when the VPN connection goes up or down. Ideal for OpenWrt-based systems or routers with shell access.

Requirements
* Router with shell (e.g., OpenWrt)
* WireGuard and/or OpenVPN installed
* Access to curl, ps, and grep (typically via BusyBox)
* Telegram bot token and chat ID

Installation Guide
1. SSH into your router
ssh root@192.168.8.1
2. Remove previous script (if any)
rm /root/vpn_monitor.sh
3. Create new script
vi /root/vpn_monitor.sh
Press I to enter insert mode, paste the full script, then press ESC, type :wq, and press Enter to save and exit.
4. Make the script executable
chmod +x /root/vpn_monitor.sh
5. Test the script manually
/root/vpn_monitor.sh
6. Debug if needed
sh -x /root/vpn_monitor.sh

Automation via Cron

Edit your crontab
crontab -e
Add the following lines:

@reboot /root/vpn_monitor.sh >/dev/null 2>&1
*/5 * * * * /root/vpn_monitor.sh >/dev/null 2>&1
This ensures the script runs at boot and every 5 minutes.

Verify cron is running
ps aux | grep cron
ps | grep cron
If cron is not running, you may need to enable/start it via init.d or system service depending on your firmware.

Output
* ✅ "VPN is connected" notification
* ❌ "VPN is disconnected" notification
Messages are sent via Telegram only if the state changes since the last run.

Credits
Developed by gatopedia 🐱 for fast and reliable VPN monitoring on embedded systems.
License
This project is licensed under the MIT License. See LICENSE for details.


