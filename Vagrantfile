# frozen_string_literal: true

# -*- mode: ruby -*-
# vi: set ft=ruby :

RUBY_V = File.read('./.ruby-version').chomp
Vagrant.configure('2') do |config|
  config.vm.box = 'bento/debian-12'
  config.vm.network 'forwarded_port', guest: 3000, host: 3030, host_ip: 'localhost'
  # change to 'virtualbox' if you use it in place of vmware
  config.vm.provider 'vmware_desktop' do |vb|
    vb.memory = '1024'
    vb.gui = false
  end
  config.vm.provision 'shell', inline: <<-SHELL
    # for nodejs repository
    # see https://github.com/nodesource/distributions#debian-and-ubuntu-based-distributions
    sudo apt-get install -y ca-certificates curl gnupg
    NODE_MAJOR=22
    curl -fsSL https://deb.nodesource.com/setup_$NODE_MAJOR.x -o nodesource_setup.sh
    sudo -E bash nodesource_setup.sh
    # for yarn repository
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    # update the apt repositories
    sudo apt-get update
    # update the system
    sudo apt-get -y dist-upgrade
    # install ruby prerequisite
    sudo apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev \
                            libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev \
                            libcurl4-openssl-dev libffi-dev \
                            nodejs yarn
    # cleanup
    sudo apt-get autoremove -y
    sudo apt-get clean -y
  SHELL

  config.vm.provision :shell, privileged: false, inline: <<~SCRIPT
    if [ ! -d ~/.rbenv ]; then
      git clone https://github.com/rbenv/rbenv.git ~/.rbenv
      echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
      echo 'eval "$(rbenv init -)"' >> ~/.bashrc
    fi
    git -C /home/vagrant/.rbenv pull

    if [ ! -d ~/.rbenv/plugins/ruby-build ]; then
      git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
      echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
    fi
    git -C /home/vagrant/.rbenv/plugins/ruby-build pull
    export PATH="$HOME/.rbenv/bin:$PATH"
    export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

    eval "$(rbenv init -)"
    rbenv install #{RUBY_V}
    rbenv global #{RUBY_V}
    gem update --system --no-doc
    rbenv rehash

    cd /vagrant
    # if [ ! -e /home/vagrant/.rbenv/shims/bundle ]; then
      gem update --system --no-doc
      rbenv rehash
    # fi
    bundle install
    yarn --no-bin-links
  SCRIPT
end
