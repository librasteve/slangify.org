#!/usr/bin/perl

`sudo apt-get update -y`;
`sudo apt-get upgrade -y`;
`sudo apt-get install tree -y`;
`sudo apt-get install caddy -y`;

`free -h`
`sudo fallocate -l 4G /swapfile`
`sudo chmod 600 /swapfile`
`sudo mkswap /swapfile`
`sudo swapon /swapfile`
`free -h`

#`sudo apt install rakudo -y`;
`curl https://rakubrew.org/install-on-perl.sh | sh`;
`eval "$(/home/ubuntu/.rakubrew/bin/rakubrew init Bash)"`;
`echo 'eval "$(/home/ubuntu/.rakubrew/bin/rakubrew init Bash)" >> ~/.bashrc`;
`export PATH=/home/ubuntu/.rakubrew/bin/:$PATH`;
`rakubrew mode shim`;
`rakubrew download`;

`sudo apt-get install docker-compose -y`;

`sudo apt-get install libssl-dev -y`;
`sudo apt-get install build-essential -y`;
`sudo apt-get install libmime-base64-urlsafe-perl`;
`zef install MIME::Base64 YAMLish JSON::Fast Linenoise --/test --verbose`

