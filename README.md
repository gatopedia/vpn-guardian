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
- Access to Telegram bot token and chat ID. (Check at the end, how to create it).
- Router or Linux device with VPN (WireGuard or OpenVPN).
- Basic knowledge of SSH and cron jobs.

---

## Installation & Usage

1. SSH into your router or Linux device (e.g., 192.168.8.1, 192.168.1.1 — replace with your actual IP):
    ```bash
    ssh root@192.168.8.1
    ```

2. Remove old versions or fix issues
    If you’ve already created the script before and want to remove it (e.g. to fix a mistake or start clean), use
    ```bash
    rm /root/vpn-guardian.sh
    ```
    This ensures you delete any previous version before creating or correcting the script.
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

## Notes

- You can change the default script path (`/root/vpn-guardian.sh`) if you prefer another location.
- Replace IP addresses or usernames to match your actual device.
- Make sure `cron` is installed and running if using a minimal Linux distribution or OpenWrt.

---

## Support & Contact

For questions or support, reach out via GitHub.

---


## 🔧 How to Create a Telegram Bot & Get Your Chat ID

1. **Create a Telegram Bot**

   * Open Telegram and search for **@BotFather**.
   * Start a conversation and type `/newbot`.
   * Follow the instructions to choose a name and username.
   * Once done, you will receive your **bot token**, which looks like:

     ```
     123456:ABC-DEF1234ghIkl-zyx57W2v1u123ew11
     ```

2. **Get Your Chat ID**

   * Send any message to your new bot from your Telegram account.
   * Then, open this URL in your browser (replace `<YOUR_BOT_TOKEN>` with your actual token):

     ```
     https://api.telegram.org/bot<YOUR_BOT_TOKEN>/getUpdates
     ```
   * You will see a JSON response. Look for something like:

     ```json
     {
       "update_id":123456789,
       "message":{
         "chat":{
           "id":123456789,
           ...
         }
       }
     }
     ```
   * The `id` value inside `chat` is your **Chat ID**.

3. **Important Notes**

   * You must send a message to the bot before using `getUpdates` — otherwise, the chat ID will not appear.
   * Make sure your bot is **not private** or blocked.

---



Happy monitoring! 🛡️🐾

