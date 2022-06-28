# Create tarballs for game files
TIMESTAMP=`date +%Y-%m-%d_%H-%M-%S`

echo "Creating backups folder..."
mkdir -p /backups

echo "Backing up minecraft world..."
# Get Minecraft world from server.properties
WORLD=$(grep level-name /config/minecraft/server.properties | cut -d '=' -f 2-)
echo "Found level: ${WORLD}"
echo "Compressing files..."
# Compress folder
tar -czvf /backups/${TIMESTAMP}_${WORLD}.tar.gz -C /data/minecraft ${WORLD}

echo "Uploading to AWS"
# Backup game server files using AWS
aws s3 cp /backups/${TIMESTAMP}_${WORLD}.tar.gz s3://bgoodmon/games/minecraft/

echo "Backing up valheim world..."
# Get Valheim world from config.json
WORLD=$(cat config/valheim/config.json | jq -r '.world')
echo "Found level: ${WORLD}"
echo "Compressing files..."
# Compress folder
tar -czvf /backups/${TIMESTAMP}_${WORLD}.tar.gz -C /data/valheim/saves/worlds ${WORLD}.db ${WORLD}.fwl

echo "Uploading to AWS"
# Backup game server files using AWS
aws s3 cp /backups/${TIMESTAMP}_${WORLD}.tar.gz s3://bgoodmon/games/valheim/


