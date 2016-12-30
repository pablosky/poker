# Requirements

- Docker 1.12+
- Docker Compose 1.8+

# Setup


Add `poker_project.dev.com` to your `/etc/hosts` file.

## Building the application

```
docker-compose build
```

## Running the application

start the app
```
docker-compose up -d
```

# Testing

First, create the test database:

```
$ docker-compose exec poker_project /bin/bash -c "RAILS_ENV=test rake db:create"
```

Then you can run the specs with:

```
$ docker-compose exec poker_project /bin/bash -c "RAILS_ENV=test bundle exec rspec"
```

# Running migrations

```
$ docker-compose exec poker_project /bin/bash -c "bundle exec rake db:migrate"
```
This app could be highly improved by adding a poker game model(to slimdown the game controller as it should be), more styles, some js(for the load of the deck) and more unitary tests.  
