# Resto API

Resto API is a Ruby on Rails 5 application intended to work with PostgreSQL 9 and above.

## Installation

Clone the Git repo

```
git clone git@github.com:zeulb/resto.git
cd resto
```

Install the gem dependencies

```
bundle install
```

## Sandbox

### Setting Up

Resto is intended to be used with PostgreSQL.
Configure your database connection in `config/database.yml`

```
[...]
default: &default
[...]
  host: localhost
  username: resto-api
  password: ...
[...]
```

### Seeding

Run

```
rails db:seed
```

To seed database with some data.

### Running Server
Start the server

```
rails server
```

A server will be run in port 3000 by default.

## Running Tests
To run all tests

```
bundle exec rspec
```