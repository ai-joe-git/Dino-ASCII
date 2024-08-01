#!/bin/bash

# Name of the virtual environment
VENV_NAME="dino_game_env"

# Name of the Python script
GAME_SCRIPT="dino_ascii.py"

# Check if Python 3 is installed
if ! command -v python3 &> /dev/null; then
    echo "Python 3 is not installed. Please install Python 3 and try again."
    exit 1
fi

# Create a virtual environment if it doesn't exist
if [ ! -d "$VENV_NAME" ]; then
    echo "Creating virtual environment..."
    python3 -m venv $VENV_NAME
fi

# Activate the virtual environment
source $VENV_NAME/bin/activate

# Install required packages
echo "Installing required packages..."
pip install keyboard

# Check if the game script exists
if [ ! -f "$GAME_SCRIPT" ]; then
    echo "Game script '$GAME_SCRIPT' not found. Please make sure it's in the same directory as this script."
    deactivate
    exit 1
fi

# Run the game
echo "Starting the game..."
python3 $GAME_SCRIPT

# Deactivate the virtual environment
deactivate
