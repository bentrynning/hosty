# Start docker-compose
echo "$TOKEN" | docker login ghcr.io -u bentrynning --password-stdin
#rm -f ~/.docker/config.json

cd "$install_dir/source"
docker compose up -d