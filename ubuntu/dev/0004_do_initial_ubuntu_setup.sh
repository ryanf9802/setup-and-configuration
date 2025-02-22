echo "Creating ~/workspace directory..."
mkdir -p ~/workspace

touch ~/.hushlogin

echo "Establishing aliases..."
source ~/setup/ubuntu/dev/0002_do_bash_aliases.sh

echo "Configuring git..."
source ~/setup/ubuntu/dev/0005_do_ubuntu_git_config.sh

echo "Styling terminal..."
source ~/setup/ubuntu/dev/0007_do_terminal_config.sh

echo "Reloading .bashrc..."
source ~/.bashrc

echo "Initial setup complete."