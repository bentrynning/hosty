# Start docker-compose
echo "$TOKEN" | docker login ghcr.io -u bentrynning --password-stdin

cd "$install_dir/source"
docker compose up -d

rm -f ~/.docker/config.json