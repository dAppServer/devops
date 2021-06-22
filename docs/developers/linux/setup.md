# Setting up a local development environment

## Packages Ubuntu

### Base Packages
```commandline
sudo apt install build-esentials git apt-transport-https ca-certificates gnupg lsb-release \
 gcc-mingw-w64-x86-64 cmake
```
### Services

#### Docker

```commandline
sudo apt-get remove docker docker-engine docker.io containerd runc
```
```commandline
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
```
```commandline
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```
```commandline
sudo apt-get update
```
```commandline
sudo apt-get install docker-ce docker-ce-cli containerd.io
```

Test a image
```commandline
sudo docker run hello-world
```
## Grab a developer checkout

We have a script to download all the code in the project structure on GitLab

[clone-projects-develop.sh](https://gitlab.com/lthn.io/resources/-/blob/master/clone-projects-develop.sh)

Or just run it below 

```commandline
wget -O - https://gitlab.com/lthn.io/resources/-/raw/master/clone-projects-develop.sh | bash
```

