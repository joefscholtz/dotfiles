BRIDGE_IP=$(ip addr show docker0 | grep -Po 'inet \K[\d.]+')
OLLAMA_PORT="11434"
WEBUI_PORT="3000"

docker run -d -p ${WEBUI_PORT}:8080 \
  --gpus all \
  -v open-webui:/app/backend/data \
  -e OLLAMA_BASE_URL=http://${BRIDGE_IP}:${OLLAMA_PORT} \
  --name open-webui \
  --restart always \
  ghcr.io/open-webui/open-webui:cuda
#Settings > Connections and add ${BRIDGE_IP}:11434
