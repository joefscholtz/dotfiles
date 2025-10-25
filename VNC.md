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

Connect to the "Desktop Hyprland" profile you created.

You should now see workspace 3 from your desktop in the Remmina window.

When you are finished, simply close the Remmina window and press Ctrl+C in the SSH tunnel terminal. This will close the tunnel. Your script on the desktop will detect the disconnect, and its cleanup function will automatically run, killing wayvnc and moving workspace 3 back to your real monitor.
