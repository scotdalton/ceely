[![Build Status](https://api.travis-ci.org/scotdalton/ceely.png?branch=master)](https://travis-ci.org/scotdalton/ceely)
[![Code Climate](https://codeclimate.com/github/scotdalton/ceely.png)](https://codeclimate.com/github/scotdalton/ceely)
[![Coverage Status](https://coveralls.io/repos/scotdalton/ceely/badge.png?branch=master)](https://coveralls.io/r/scotdalton/ceely)
[![Dependency Status](https://gemnasium.com/scotdalton/ceely.png)](https://gemnasium.com/scotdalton/ceely)

To run assignments on a Mac
(assumes [git](http://git-scm.com/), 
[rvm](http://rvm.io), [bundler](http://bundler.io/) and
[OpenJDK](http://openjdk.java.net/))

    $ git clone https://github.com/scotdalton/ceely.git
    $ cd ceely
    $ ./bin/assignment N

To run tests on a Mac (same assumptions as above)

    $ git clone https://github.com/scotdalton/ceely.git
    $ cd ceely
    $ bundle install
    $ bundle exec rake

Or you could just see what [travis](https://travis-ci.org/scotdalton/ceely) says about it.

Hope to make this a [vagrant box](http://www.vagrantup.com/)
(probably Ubuntu) and distribute it that way.
