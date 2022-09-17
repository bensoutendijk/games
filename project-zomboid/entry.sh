#!/bin/bash

# Update Steam and Project Zomboid
./steamcmd.sh +force_install_dir /server  +login anonymous +app_update 380870 +quit

# Check to see if server files exist for project zomboid
