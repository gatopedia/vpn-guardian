# vpn-guardian.sh

**Version:** 1.0  
**Author:** [gatopedia]

---

## What is vpn-guardian?

`vpn-guardian.sh` is a lightweight shell script designed for routers or Linux-based devices running a single VPN tunnel (WireGuard or OpenVPN). It monitors the VPN connection status and sends a Telegram notification **only when the VPN status changes** (connected → disconnected or vice versa).

This means you won’t get spammed with constant status messages — only important status changes trigger alerts. For example, if the VPN disconnects due to power loss or network issues and then reconnects, you will receive a notification for both events.

---

## Features

- Supports monitoring of WireGuard and OpenVPN tunnels.
- Sends notifications via Telegram bot API.
- Avoids multiple simultaneous script runs using a lockfile.
- Sends alerts **only when the VPN connection status changes**.
- Simple to setup on routers or Linux systems.
  
---

## Requirements

- `curl` command available.
- Access to Telegram bot token and chat ID.
- Router or Linux device with VPN (WireGuard or OpenVPN).
- Basic knowledge of SSH and cron jobs.

---

## Installation & Usage

1. SSH into your router or device:
    ```bash
    ssh root@192.168.8.1
    ```

2. Remove old versions if any:
    ```bash
    rm /root/vpn-guardian.sh
    ```

3. Create the script file:
    ```bash
    vi /root/vpn-guardian.sh
    ```
    Paste the contents of `vpn-guardian.sh` script, then save and exit (press `i` to insert, paste, then `Esc` → `:wq` → `Enter`).

4. Make the script executable:
    ```bash
    chmod +x /root/vpn-guardian.sh
    ```

5. Test run the script:
    ```bash
    /root/vpn-guardian.sh
    ```

6. Check script debug output (optional):
    ```bash
    sh -x /root/vpn-guardian.sh
    ```

7. Setup cron job to run the script every 5 minutes:
    ```bash
    crontab -e
    ```
    Add these lines:
    ```
    @reboot /root/vpn-guardian.sh >/dev/null 2>&1
    */5 * * * * /root/vpn-guardian.sh >/dev/null 2>&1
    ```

8. Verify cron is running:
    ```bash
    ps aux | grep cron
    ```

---

## How it works

- The script checks if the VPN is connected via WireGuard or OpenVPN.
- It reads the previous VPN status from a temporary file.
- If the status has changed, it sends a Telegram message to notify you.
- A lockfile prevents multiple simultaneous executions.
- Only status changes trigger notifications, avoiding message spam.

---

## License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

---

## Contribution

Feel free to open issues or submit pull requests on GitHub.

---

## Support & Contact

For questions or support, reach out via GitHub or Telegram bot.

---

Happy monitoring! 🛡️🐾

