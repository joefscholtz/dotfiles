sudo systemctl enable --now ollama

OLLAMA_CONF_DIR="/etc/systemd/system/ollama.service.d"
sudo mkdir -p "$OLLAMA_CONF_DIR"
cat <<EOF | sudo tee "$OLLAMA_CONF_DIR/override.conf"
[Service]
Environment="OLLAMA_HOST=0.0.0.0"
EOF

sudo systemctl daemon-reload
sudo systemctl restart ollama

sleep 10

ollama pull deepseek-coder-v2:16b

ollama pull deepseek-r1:14b
