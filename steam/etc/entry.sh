# export templdpath=$LD_LIBRARY_PATH
# export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH
# export SteamAppId=892970

# /home/steam/Steam/steamapps/common/Valheim\ dedicated\ server/valheim_server.x86_64 -name "BGood Good Times | Valheim Poggers" -world "BirdLaw" -password "asiancreampie" -public 1 > /dev/null &

# export LD_LIBRARY_PATH=$templdpath

# echo "Server started"
# echo ""
# while :
# do
# TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
# echo "valheim_server: timestamp ${TIMESTAMP}"
# sleep 60
# done
#!/bin/bash
mkdir -p "${STEAMAPPDIR}" || true  

# Override SteamCMD launch arguments if necessary
# Used for subscribing to betas or for testing
if [ -z "$STEAMCMD_UPDATE_ARGS" ]; then
	bash "${STEAMCMDDIR}/steamcmd.sh" +force_install_dir "$STEAMAPPDIR" +login anonymous +app_update "$STEAMAPPID" +quit
else
	steamcmd_update_args=($STEAMCMD_UPDATE_ARGS)
	bash "${STEAMCMDDIR}/steamcmd.sh" +force_install_dir "$STEAMAPPDIR" +login anonymous +app_update "$STEAMAPPID" "${steamcmd_update_args[@]}" +quit
fi

# Switch to workdir
cd "${STEAMAPPDIR}"

ls /home/steam/valheim
${STEAMAPPDIR}/valheim_server.x86_64 -name "BGood Good Times | Valheim Poggers" -world "BirdLaw" -password "asiancreampie" -public 1
