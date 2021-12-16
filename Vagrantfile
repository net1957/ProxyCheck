# -*- mode: ruby -*-
# vi: set ft=ruby :

RUBY_V = File.open('./.ruby-version', &:read).chomp
Vagrant.configure('2') do |config|
  config.vm.box = 'bento/debian-10.10'
  config.vm.network 'forwarded_port', guest: 3000, host: 8080, host_ip: 'localhost'
  config.vm.provider 'virtualbox' do |vb|
    vb.memory = '1024'
  end
  config.vm.provision 'shell', inline: <<-SHELL
    # for nodejs repository
    curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
    # for yarn repository
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    # update
    sudo apt-get update
    # install ruby prerequisite
    # select the wanted ruby version rubyx.x & rubyx.x-dev
    sudo apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev \
                            libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev \
                            libcurl4-openssl-dev libffi-dev \
                            nodejs yarn
    # cleanup
    sudo apt-get autoremove -y
    sudo apt-get autoclean -y
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
    if [ ! -e .rbenv/versions/#{RUBY_V} ]; then
      rbenv install #{RUBY_V}
      rbenv global #{RUBY_V}
      gem update --system --no-doc
      rbenv rehash
    fi
    cd /vagrant
    # if [ ! -e /home/vagrant/.rbenv/shims/bundle ]; then
      gem update --system --no-doc
      rbenv rehash
    # fi
    bundle install
  SCRIPT
end
