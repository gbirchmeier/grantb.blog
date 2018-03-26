grantb.blog
===========

It's my blog.  I work on it in fits and starts.
Sometimes years pass between updates.

It's not as good as my professional work because
nobody pays me for this.

To upload images for use in blog posts:
---
* ssh them into `/home/blog/blog_uploads/<env>`
* web server maps this dir to `/blog_uploads`

Testing
---
Just `rake test` and `rake cucumber` for now

Deployment
---
`bundle exec cap <env> deploy`

* "production" deploys branch `deploy-prod`
* "staging" deploys branch `deploy-staging`

You have to manually merge to the above branches.

First-time install
---
You need to create an admin user.  (There's a simple seed, but it's really meant for dev.)

Until I implement something better, I suggest just going into `rails console` and doing this:

    user = User.create(
      username:"your_username",
      password:"your_password",
      password_confirmation:"your_password",
      email:"youremail@example.com",
    )
    user.save!


Running console in deployments:
---
`RAILS_ENV=staging bundle exec rails console`

Backing up the block content:
---
`bundle exec cap <env> backup`

And scp these:
* `/home/blog/blog_uploads`
* `/home/blog/legacy_files` (until I move it to static)


Shitty platform issues
===

Installing a MariaDB docker on Mac for dev:
---

[This page](https://hub.docker.com/_/mariadb/) was my start.

This command did the trick for me:

    docker run -p 3306:3306 --name blog-mariadb -e MYSQL_ALLOW_EMPTY_PASSWORD=yes -d mariadb:10.3.5

With that, you can reach the container's DB at 127.0.0.1:3306.
(That is the *only* way you can reach it.  Using "localhost" won't work.)

The dev and test config files are expecting this.


Installing mysql2 on Mac dev:
---

OS X has always gotta make it a damn fight.

This is what got me through it last time:

* update xcode
* `xcode-select --install`
* `brew install mysql`
* `gem install mysql2 -v '0.3.17' -- --with-mysql-dir=/usr/local/opt/mysql`

Maybe MariaDB might work instead for the last two steps, but I'm not going to
break what's working to try it.


Issues on my CentOS platform:
---

**Bundler**
Bundler 1.5.0 was installed by default, but it was being stupid,
so I installed 1.6.6.

* `gem install bundler -v 1.6.6`

**Other deps**
* `yum install mariadb`
* `yum install MariaDB-devel.x86_64`
* `yum install nodejs` (not sure why, but Rails wants it)

*Sysadmin stuff I always forget*

* `chkconfig --list`
* `chkconfig mysql on`
* `service mysql start` or `restart`

