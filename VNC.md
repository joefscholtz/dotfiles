On Desktop and on Laptop:

install vnc.packages

```bash
cd <dots>/install
export DOTS_INSTALL=$(pwd)
bash -c ./packaging/vnc.sh
bash -c ./config/ufw.sh
```

On Desktop

get public ip

```bash
curl ifconfig.me
```

Open a terminal and run the script: ./your-wayvnc-script.sh

```bash
cd <dots>/install
export DOTS_INSTALL=$(pwd)
bash -c ./packaging/vnc.sh
bash -c ./config/ufw.sh
```


wayvnc will start and wait for a connection.

On Laptop:

Open a terminal and start the tunnel: ssh -L 5900:localhost:5900 your_desktop_user@your_desktop_public_ip

Enter your desktop's password when prompted.

On Laptop (Again):

Open Remmina.

Create profile

Configure Remmina
Now, open Remmina on your laptop and create a new connection profile.

Name: Give it a name (e.g., "Desktop Hyprland").

Protocol: Select VNC.

Server: This is the most important part. You are connecting to your own laptop's port, which the tunnel is forwarding.

localhost:5900 (or 127.0.0.1:5900)

User name: Enter your_desktop_user.

Password: Enter your_desktop_password. By default, wayvnc uses PAM, so this is your normal desktop login password.

Color depth: True color (24 bit) is recommended.

Quality: Start with Good. If it's laggy, you can lower it to Medium later.

Save and connect.

Connect to the "Desktop Hyprland" profile you created.

You should now see workspace 3 from your desktop in the Remmina window.

When you are finished, simply close the Remmina window and press Ctrl+C in the SSH tunnel terminal. This will close the tunnel. Your script on the desktop will detect the disconnect, and its cleanup function will automatically run, killing wayvnc and moving workspace 3 back to your real monitor.



Yes, to connect from any network (like a coffee shop or another house), you must change one setting on your home router.

You cannot just use it from an external network without this change.

Here’s the why and how.

Why You Need This: Port Forwarding
Think of your router as the single, locked front door to your entire apartment building (your home network). Your desktop is one of the apartments inside (like 192.168.1.50).

Your Public IP (80.90.100.110) is the street address of the building.

The Port (22 for SSH) is like the apartment number.

When you're on an outside network, your SSH command (ssh ... @80.90.100.110) arrives at the front door. The router (the doorman) sees the request for "port 22" but, for security, has instructions to turn everyone away.

You need to give the doorman a new rule. This rule is called Port Forwarding. The rule is: "When someone from the outside knocks asking for port 22, send them directly to the private IP of my desktop (e.g., 192.168.1.50)."

How to Set Up Port Forwarding (3 Steps)
You only need to do this once.

Step 1: Find Your Desktop's Private IP (and Router IP)
On your desktop (the host machine), open a terminal and find two things:

Your Desktop's Private IP:

Bash

ip addr show
Look for your main network interface (like enp... or wlan...). The IP will be next to inet. It will look something like 192.168.1.50/24. Your IP is 192.168.1.50.

Your Router's IP (Gateway):

Bash

ip route | grep default
The output will be something like default via 192.168.1.1 .... Your router's IP is 192.168.1.1.

Step 2: Set a Static Private IP for Your Desktop (Critical!)
That 192.168.1.50 IP your desktop has can change every time you reboot. This would break your port forwarding rule. You must tell your router to always give your desktop that same IP.

This is called DHCP Reservation or "Static DHCP."

Open a browser and go to your router's admin page (e.g., http://192.168.1.1).

Log in (the password is often on a sticker on the router).

Find the "DHCP Settings" or "LAN Settings" page.

Look for "DHCP Reservation," "Address Reservation," or "Static Leases."

Add a new rule. It will ask for the MAC Address of your desktop (you can find this in the ip addr show output, it's the link/ether address) and the IP you want to assign it (use the 192.168.1.50 you just found).

Now your desktop's private IP will never change, and your port forwarding rule won't break.

Step 3: Create the Port Forwarding Rule on Your Router
In your router's admin page, find the "Port Forwarding," "NAT," or "Virtual Servers" section.

Create a new rule with these settings:

Service Name: SSH (or anything you want)

External Port: 22

Internal Port: 22

Protocol: TCP

Internal IP Address: 192.168.1.50 (the static private IP you set in Step 2)

Save and apply the settings. The router may reboot.

The Final Workflow
Once you've done this, your setup is complete. From any network in the world, your workflow will be:

On Desktop: Run your wayvnc script.

On Laptop:

Get your desktop's public IP (e.g., by searching "what is my IP" on your desktop's browser or using the curl ifconfig.me command).

Open a terminal and run the SSH tunnel command:

Bash

ssh -L 5900:localhost:5900 your_desktop_user@YOUR_PUBLIC_IP
Open Remmina and connect to localhost:5900.
