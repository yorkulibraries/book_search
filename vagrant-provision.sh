#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


/vagrant/setup.sh

. ~/.profile

ln -s /vagrant missing_books
cd missing_books

bundle
rails db:migrate
rails db:seed


cat system.d/missing-books.service | sed 's/ubuntu/ubuntu/g' > /tmp/missing-books.service
sudo cp /tmp/missing-books.service /lib/systemd/system/

sudo systemctl daemon-reload
sudo systemctl enable missing-books
sudo systemctl start missing-books
sudo systemctl status missing-books


