#!/usr/bin/bash

rbdooom3bfg_moddb_url="https://www.moddb.com/mods/rbdoom-3-bfg/downloads"
RBDOOM3_BFG_VERSION="1.5.1.2"
# Set game folder paths
rbdoom3bfg_data_dir=${XDG_DATA_HOME}/rbdoom3bfg
rbdoom3bfg_base_dir=${rbdoom3bfg_data_dir}/base

# Check data folder
if [ ! -d ${rbdoom3bfg_data_dir} ]
then
    mkdir -p ${rbdoom3bfg_data_dir}
fi

# Check base folder
if [ ! -d ${rbdoom3bfg_base_dir} ]
then
    zenity --width=400 --error --title="Game data files not found" \
    --no-wrap --text="The /base game folder must be copied to:\n${rbdoom3bfg_base_dir}" \
    --ok-label "Close"
    exit 1
elif [ ! -f ${rbdoom3bfg_data_dir}/.setup ]
then
    # Base folder exists, but it is not initialized
    echo "Copying data patches..."
    cp --recursive /app/share/rbdoom3bfg/base/* --target-directory ${rbdoom3bfg_base_dir}
    touch ${rbdoom3bfg_data_dir}/.setup
    echo "Data patches copied"
fi

# Check for presence of the RBDOOM3-BFG mod
if [ ! -f ${rbdoom3bfg_data_dir}/.rbdoom3bfg_version ]
then
    # RBDOOM3-BFG mod is not installed
    zenity --width=400 --error --title="RBDOOM3-BFG mod not found" \
    --no-wrap --text="The RBDOOM3-BFG mod was not found in: \n${rbdoom3bfg_base_dir}\nA browser will now be opened so you can download it." \
    --ok-label "Close"
    xdg-open "${rbdooom3bfg_moddb_url}"
    exit 1
elif [ $(cat ${rbdoom3_bfg_data_dir}/.rbdoom3bfg_version) != $RBDOOM3_BFG_VERSION ]
then
    # RBDOOM3-BFG mod is installed but outdated
    zenity --width=400 --error --title="RBDOOM3-BFG mod not found" \
    --no-wrap --text="The RBDOOM3-BFG mod was found in: \n${rbdoom3bfg_base_dir}\nbut is outdated. Please download the latest version from\n${rbdoom3bfg_moddb_url} and install it." \
    --ok-label "Close"
    xdg-open "${rbdoom3bfg_moddb_url}"
    exit 1
fi

# Run game engine
exec /app/bin/RBDoom3BFG "$@"
