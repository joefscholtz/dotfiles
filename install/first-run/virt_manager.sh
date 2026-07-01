sudo systemctl enable --now libvirtd.service
sudo systemctl enable --now virtlxcd.socket
sudo usermod -aG libvirt $USER
newgrp libvirt

sudo iptables -I FORWARD -i virbr0 -j ACCEPT
sudo iptables -I FORWARD -o virbr0 -j ACCEPT

# sudo iptables -I FORWARD -p udp --dport 53 -j ACCEPT
# sudo iptables -I FORWARD -p tcp --dport 53 -j ACCEPT
#
# Trust all incoming traffic originating from the VMs to the host
sudo ufw allow in on virbr0
sudo ufw allow out on virbr0

# Allow routing (forwarding) across the libvirt bridge
sudo ufw route allow in on virbr0
sudo ufw route allow out on virbr0

# Allow libvirt VMs to access host DNS and DHCP
sudo ufw allow in on virbr0 to any port 53 proto udp comment 'libvirt-dns-udp'
sudo ufw allow in on virbr0 to any port 53 proto tcp comment 'libvirt-dns-tcp'
sudo ufw allow in on virbr0 to any port 67 proto udp comment 'libvirt-dhcp'
sudo ufw allow out on virbr0 to any port 68 proto udp comment 'libvirt-dhcp-reply'

# Turn on the firewall
sudo ufw --force enable

# Enable UFW systemd service to start on boot
sudo systemctl enable --now ufw

# Turn on protections
sudo ufw reload
