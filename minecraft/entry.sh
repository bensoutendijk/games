echo "Fetching server config from aws"
FILENAME=$(aws s3 ls bgoodmon/games/minecraft/ | grep _config | sort -r | head -1 | awk '{print $4}')
if [ ! -z "$FILENAME" ]
    then
        mkdir -p /tmp
        aws s3 cp s3://bgoodmon/games/minecraft/${FILENAME} /tmp/${FILENAME}

        echo "Extracting data from ${FILENAME}..."
        mkdir -p /config
        tar -xf /tmp/${FILENAME} -C /data

        chown 1000:1000 /config

        echo "Cleaning up..."
        rm /tmp/${FILENAME}
    else
        echo "No config found. New config will be created..."
    fi

WORLD=$(grep level-name /config/server.properties | cut -d '=' -f 2-)

echo "Checking if game data exists in '/data/${WORLD}'"

if [ -d "/data/${WORLD}" ] 
then
    echo "Level already exists in volume."
else
    echo "Fetching game data from AWS..."
    FILENAME=$(aws s3 ls bgoodmon/games/minecraft/ | grep ${WORLD} | grep _world | sort -r | head -1 | awk '{print $4}')

    if [ ! -z "$FILENAME" ]
    then
        mkdir -p /tmp
        aws s3 cp s3://bgoodmon/games/minecraft/${FILENAME} /tmp/${FILENAME}

        echo "Extracting data from ${FILENAME}..."
        mkdir -p /data/${WORLD}
        tar -xf /tmp/${FILENAME} -C /data

        chown 1000:1000 /data/${WORLD}

        echo "Cleaning up..."
        rm /tmp/${FILENAME}
    else
        echo "No backups found for ${WORLD}. New world will be created..."
    fi
fi

bash /start
