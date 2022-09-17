#!/bin/bash

# Update Steam and Project Zomboid
/home/steam/steamcmd/steamcmd.sh +force_install_dir ${STEAMAPPDIR} +login anonymous +app_update 380870 +quit

# Check to see if server files exist for project zomboid

~/app/start-server.sh -adminpassword asiancreampie