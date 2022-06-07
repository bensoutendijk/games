export WORLDPATH='/home/steam/.config/unity3d/IronGate/Valheim/worlds'
export WORLD=$(cat /config/config.json | jq -r '.world')


echo "Checking if game data exists in '${WORLDPATH}/${WORLD}.fwl"
if [ -f "${WORLDPATH}/${WORLD}.fwl" ] 
then
    echo "Level already exists in volume."
else
    echo "Fetching game data from AWS..."
    FILENAME=$(aws s3 ls bgoodmon/games/valheim/ | grep ${WORLD} | sort -r | head -1 | awk '{print $4}')

    if [ ! -z "$FILENAME" ]
    then
        mkdir -p /tmp
        aws s3 cp s3://bgoodmon/games/valheim/${FILENAME} /tmp/${FILENAME}

        echo "Extracting data from ${FILENAME}..."
        mkdir -p ${WORLDPATH}
        tar -xvf /tmp/${FILENAME} -C ${WORLDPATH}

        echo "Syncing server config with git repo"
        export PORT=$(cat /config/config.json | jq -r '.port')
        export PASSWORD=$(cat /config/config.json | jq -r '.password')
        export PUBLIC=$(cat /config/config.json | jq -r '.public')
        export NAME=$(cat /config/config.json | jq -r '.name')

        echo "Cleaning up..."
        rm /tmp/${FILENAME}
    else
        echo "No backups found for ${WORLD}. New world will be created..."
    fi
fi


echo "Setting up file systems"
STEAM_UID=${PUID:=1000}
STEAM_GID=${PGID:=1000}

# Save Files
mkdir -p "${SAVE_LOCATION}"

# Mod staging location
mkdir -p "${MODS_LOCATION}"

# Valheim Server
mkdir -p "${GAME_LOCATION}"
mkdir -p "${GAME_LOCATION}/logs"
chown -R ${STEAM_UID}:${STEAM_GID} "${GAME_LOCATION}"
chown -R ${STEAM_UID}:${STEAM_GID} "${GAME_LOCATION}"

mkdir -p /home/steam/scripts
chown -R ${STEAM_UID}:${STEAM_GID} /home/steam/scripts
chown -R ${STEAM_UID}:${STEAM_GID} /home/steam/

exec gosu steam bash /home/steam/scripts/start_valheim.sh -PORT 8888
