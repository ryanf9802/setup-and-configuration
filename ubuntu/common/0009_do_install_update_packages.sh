#!/bin/bash

echo -e "\e[33m [0009] Upgrading packages... \e[0m"
sudo apt upgrade -y
echo -e "\e[33m [0009] Successfully upgraded packages. \e[0m"

echo -e "\e[33m [0009] Installing packages... \e[0m"
sudo apt install -y jq
echo -e "\e[33m [0009] Successfully installed packages. \e[0m"
