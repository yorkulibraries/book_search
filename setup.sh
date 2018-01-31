#!/bin/bash

sudo timedatectl set-timezone America/Toronto

sudo apt-get update

sudo apt-get install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev
sudo apt-get install -y libsqlite3-dev sqlite3 nodejs libreadline-dev git 

git clone https://github.com/rbenv/rbenv.git ~/.rbenv

echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.profile
echo 'eval "$(rbenv init -)"' >> ~/.profile

. ~/.profile

git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
rbenv install 2.5.0
rbenv global 2.5.0

echo "gem: --no-document" >> ~/.gemrc 

gem install bundler --no-document
gem install rails --no-document

