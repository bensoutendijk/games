# Create tarballs for game files
TIMESTAMP=`date +%Y-%m-%d_%H-%M-%S`

mkdir -p backups

tar -czvf ./backups/${TIMESTAMP}_minecraft.tar.gz minecraft

# Backup game server files using AWS

docker run --rm -ti  -v /home/ben/droplet/.aws:/root/.aws  -v /home/ben/droplet/backups:/backups  amazon/aws-cli s3 cp /backups/* s3://bgoodmon/games/

