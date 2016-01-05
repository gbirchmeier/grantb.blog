grantb.blog
===========

Just using bundler for now.


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
---

**Bundler**
Bundler 1.5.0 was installed by default, but it was being stupid,
so I installed 1.6.6.

* `gem install bundler -v 1.6.6`

**Other deps**
* `yum install mariadb`
* `yum install MariaDB-devel.x86_64`
* `yum install nodejs` (not sure why, but Rails wants it)

Sysadmin stuff I always forget
---

* `chkconfig --list`
* `chkconfig mysql on`
* `service mysql start` or `restart`

