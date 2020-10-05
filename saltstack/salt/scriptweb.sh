sudo apt-get install build-essential -y
cd ~
curl -O https://dl.google.com/go/go1.15.2.linux-amd64.tar.gz
tar xvf go1.15.2.linux-amd64.tar.gz
sudo chown -R root:root ./go
sudo mv go /usr/local
export GOROOT=/usr/local/go
export GOHOME=$GOROOT/work
export GOPATH=/usr/local/go/bin
#Este comando de PATH no sirve, toca ingresarlo manual en los minions
export PATH=$PATH:/usr/local/go/bin
source $HOME/.bashrc
cd /srv/webfiles/
go mod init example.com/hello
go run hello.go
