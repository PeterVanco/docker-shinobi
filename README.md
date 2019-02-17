## Overview

Run https://shinobi.video/ on Docker on a Raspberry Pi (tested on Raspberry Pi 3 B+)

## Requirements

Install Docker as described here: https://www.raspberrypi.org/blog/docker-comes-to-raspberry-pi/

```
curl -sSL https://get.docker.com | sh
```

Get some dependencies

```
sudo apt-get install -y git-core python3 python3-pip
sudo pip3 install docker-compose
```

Checkout this the repo

```
git clone https://github.com/PeterVanco/docker-shinobi
```

## Usage

Create containers:

```
cd docker-shinobi
docker-compose up -d --build
```

Log in:

```
Web Address : http://xxx.xxx.xxx.xxx:8080/super
Username : admin@shinobi.video
Password : administrator
```

More info here: https://shinobi.video/docs/start#content-docker
