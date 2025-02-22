echo "Creating ~/workspace directory..."
mkdir -p ~/workspace

echo "Establishing aliases..."
source ~/setup/ubuntu/dev/0002_do_bash_aliases.sh

echo "Configuring git..."
source ~/setup/ubuntu/dev/0005_do_ubuntu_git_config.sh

echo "Reloading .bashrc..."
source ~/.bashrc

echo "Initial setup complete."