echo "BeamMP Installer"

if ! [ -x "$(command -v curl)" ]; then
  echo "* curl is required in order for this script to work."
  echo "* install using apt (Debian and derivatives) or yum/dnf (CentOS)"
  exit 1
fi

REPO_URL=""

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
echo "Running server for first time"
chmod +x ./BeamMP-Server-linux
sudo ./BeamMP-Server-linux
