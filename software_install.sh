#!/bin/bash

# Configuration
PACKAGE_LIST="/path/to/package_list.txt"

# Function to install packages
install_packages() {
    while IFS= read -r package; do
        echo "Installing $package..."
        sudo apt-get update
        sudo apt-get install -y $package
        if [ $? -ne 0 ]; then
            echo "Failed to install $package"
        else
            echo "$package installed successfully"
        fi
    done < "$PACKAGE_LIST"
}

# Main script
install_packages
echo "Software installation completed."
