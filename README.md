Webistrano - Capistrano deployment the easy way
===============================================

[![Build Status](https://secure.travis-ci.org/jeromemacias/webistrano.png)](http://travis-ci.org/jeromemacias/webistrano) ![project status](http://stillmaintained.com/jeromemacias/webistrano.png)

About
-----

Webistrano is a Web UI for managing Capistrano deployments.  
It lets you manage projects and their stages like test, production, and staging with different settings.  
Those stages can then be deployed with Capistrano through Webistrano.

An extra feature to easily deploy Symfony2 projects was added, with the help of Capifony.


Installation
------------

### 1. Dependencies

Install all gem dependencies via the gem bundler:

```bash
> bundle install
```

### 2. Configuration

Copy `config/webistrano_config.rb.sample` to `config/webistrano_config.rb` and edit appropriatly.  
In this configuration file you can set the mail settings of Webistrano.

Generate a file (`config/initializers/session_store.rb`) with a random secret used to secure session data :

```bash
> bundle exec rake generate_session_store
```

### 3. Database

Copy `config/database.yml.sample` to `config/database.yml` and edit to resemble your setting.  
You need at least the production database.  
The others are optional entries for development and testing.

Then create the database structure with Rake:

```bash
> bundle exec rake db:migrate RAILS_ENV=production
```

### 4. Start Webistrano  

```bash
> bundle exec thin -e production start
```

Webistrano is then available at http://host:3000/

The default user is `admin`, the password is `admin`.  
Please change the password after the first login.
  
Author
------

Jonathan Weiss <jw@innerewut.de>

Contributor
-----------

Jérôme Macias, Joeri Verdeyen
  
License
-------
 
Code: BSD, see LICENSE.txt
Images: Right to use in their provided form in Webistrano installations. No other right granted.
