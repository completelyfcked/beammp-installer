echo "BeamMP Installer"

if ! [ -x "$(command -v curl)" ]; then
  echo "* curl is required in order for this script to work."
  echo "* install using apt (Debian and derivatives) or yum/dnf (CentOS)"
  exit 1
fi

REPO_URL="https://raw.githubusercontent.com/completelyfcked/beammp-installer/main/"

wget https://www.beammp.com/server/BeamMP_Server.zip
mkdir BeamMP_Server && mv ./BeamMP_Server.zip ./BeamMP_Server/zip.zip && cd BeamMP_Server
sudo apt-get install unzip
unzip ./zip.zip
rm -r BeamMP-Server.exe
rm -r zip.zip

echo "Installing Dependencies"
sudo apt-get install libz-dev
sudo apt-get install rapidjson-dev
sudo apt-get install liblua5.3
sudo apt-get install libssl-dev
sudo apt-get install libwebsocketpp-dev
sudo apt-get install libcurl4-openssl-dev
sudo apt-get install git
sudo apt-get install make
sudo apt-get install cmake
sudo apt-get install g++
echo "Installed Dependencies"

echo "Server Name: ";
read server_name;
echo "Auth Key: ";
read auth_key;
echo "Description: ";
read description;

echo "Editing config file"
rm -r ./ServerConfig.toml
cat << EOF > ServerConfig.toml
[General]
AuthKey = '${auth_key}'
Debug = false
Description = '${description}'
Map = '/levels/gridmap_v2/info.json'
MaxCars = 1
MaxPlayers = 10
Name = '${server_name}'
Port = 30814
Private = true
ResourceFolder = 'Resources'
EOF
echo "Wrote config"

echo "Launching server"
chmod +x ./BeamMP-Server-linux
sudo ./BeamMP-Server-linux
PID=$!
sleep 10
kill $PID
echo "Server stopped"

PUBLIC_IP="$(cut -d ' ' -f 1 <<< "$(hostname -I)")"
echo "\nServer is setup"
echo "Public IP: ${PUBLIC_IP}"
echo "Server Name: ${server_name}"
echo "Port: 30814"
echo "Private Server: true"
echo "Map: gridmap_v2"
echo "\nYou can always change the settings in ServerConfig.toml"
echo "Launch the server by running:\nsudo ./BeamMP*"
