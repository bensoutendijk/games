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
tar -czvf /backups/${TIMESTAMP}_${WORLD}.tar.gz /data/minecraft/${WORLD}

echo "Uploading to AWS"
# Backup game server files using AWS
aws s3 cp /backups/* s3://bgoodmon/games/minecraft/

