ProxyCheck
==========

Proxy checker

DESCRIPTION
-----------

ProxyCheck show the response of a proxy script for URLs(s).

Proxy scripts are well described here: https://en.wikipedia.org/wiki/Proxy_auto-config

INSTALLATION
------------

ProxyCheck is a Rails 5.1 application and all rails prerequisites applies.

Node.js, Yarn, Git and Ruby 2.3 or higher should be installed on the system.

Clone this repository and install gems:
````
git clone https://github.com/net1957/proxyCheck.git
cd proxyCheck
bundle install
rake git_version
````

It should work on all nix systems, but not on windows due to the lack of support by the therubyracer gem.

You can use Vagrant to test it. A Vagrantfile based on ubuntu/trusty64 is provided.

CONFIGURATION
-------------

All Rails configuration apply, but no database is used, so activerecord is disabled. See config/application.rb file for details.

You can use your own logo on the top of the page (optional).

Simply put a png file (159*18 pixels) in app/assets/images directory and set the environment variable LOGO with the filename (without path).

example:
````
LOGO=mylogo.png
````

USAGE
-----

Start the server
````
rails server
````

Connect to your application with your URL (default to http://localhost:3000) and you have three input fields:
* Script or script URL: you can put the source of your script or the URL of the script (the same as in your navigator).
* Client IPv4: the IP of your client. Default to the IP seen by the server.
* URL(s): you can add one or many URL to check, one per line.

Hit the run button to see the results.

You can also compress your script if you hit the compress button and save it locally.

CREDITS
------

This application is build on top of the proxy_pac_rb gem. 

LINKS
-----

* Node.js: https://nodejs.org
* Yarn : https://yarnpkg.com
* Ruby: https://www.ruby-lang.org
* Rails: http://rubyonrails.org
* proxy_pac_rb: https://github.com/fedux-org/proxy_pac_rb
* Vagrant: https://www.vagrantup.com/
* Git: https://git-scm.com/


LICENSE
-------

(The MIT License)

Copyright (c) 2017 Serge Kueny

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
