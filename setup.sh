#!/bin/bash

sudo timedatectl set-timezone America/Toronto

sudo apt-get update

sudo apt-get install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev
sudo apt-get install -y libsqlite3-dev sqlite3 nodejs libreadline-dev git apache2

git clone https://github.com/rbenv/rbenv.git ~/.rbenv

echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.profile
echo 'eval "$(rbenv init -)"' >> ~/.profile

. ~/.profile

git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
rbenv install 2.5.0
rbenv global 2.5.0

echo "gem: --no-document" >> ~/.gemrc

gem install bundler
gem install rails

cd ~/book_search
bundle
rails db:migrate
rails db:seed

cat system.d/book-search.service | sed 's/ubuntu/ubuntu/g' > /tmp/book-search.service
sudo cp /tmp/book-search.service /lib/systemd/system/

sudo systemctl daemon-reload
sudo systemctl enable book-search
sudo systemctl start book-search
sudo systemctl status book-search

sudo cp apache/book-search.conf /etc/apache2/conf-available/
sudo a2enconf book-search
sudo a2enmod proxy
sudo a2enmod proxy_http

[ -f tmp/libapache2-mod-auth-pyork_2.0.3_amd64.deb ] && sudo dpkg -i tmp/libapache2-mod-auth-pyork_2.0.3_amd64.deb && sudo a2enmod auth_pyork

sudo systemctl enable apache2
sudo systemctl restart apache2
sudo systemctl status apache2
