# Ingresse Developer Test

This repository contains a possible solution for the requested project in the Ingresse Backend Developer Test, better described in [this gist](https://gist.github.com/vitorleal/158e4e3870337dacf9475a5a27e5c7c9).

## Introduction

The project was developed using Ruby as the programming language, and Rails as the main development framework. As requested, the REST API was fully created, and it has an extensible test coverage, with both unit and integration tests.

Besides that, PostgreSQL was the database of choice, and a cache layer using Redis is available.

It is possible to check the API's functionality on a heroku app. You can find how to properly access it and make requests to it below.

**OBS:** Unfortunately, some functionalities required on the test were not developed, because there wasn't enough time for me to create them.

## Setup

Before setting up the project, the following must be installed in your machine:
- Ruby 2.6.5 *(I strongly recommend installing it through rvm. There is a nice tutorial on https://rvm.io/ on how to install it)*
- Redis 5.0+
- PostgreSQL 11.0+ 

With all the above installed and properly configured, the first step to setup the project is to install its dependencies, running the following command:

```
gem install bundler
bundle install
```

Then, it is necessary to setup environment configurations to run it locally. On your .env file fill in the correct informations of your database user, name, pass, and whichever more info you need to properly connect the application to PostgreSQL and Redis. 

**OBS: to give proper permissions to your user on PostgreSQL, don't forget to run `createuser --interactive`, in order to grant super admin permissions to him.**

With that done, there are just two more steps to do before starting the server: creating the database and running the migrations. To accomplish that, run the following on the command line.

```
rails db:create
rails db:migrate
```

Finally, simply run `rails s` to start puma server on localhost, at port 3000 (or another, if you have changed it on .env).

## Test Suite

Before diving into the API, I recommend to check the application's test suite, which I have made extending which was requested on the exercise. For instance, there is a test to check if the password attribute is not being passed as a parameter on a response on the API. There is also a test to ensure the password is encrypted on the database. And more!

I have used RSpec as my testing tool, and to run it, simply use the following command on your terminal:

```
rspec
```

**OBS:** I have tried to create tests with pretty auto-explaining naming methods, in order to be extremely straightforward.

## Testing the API locally

With your favorite REST Client, it is possible make GET, POST, PATCH and DELETE requests to the API as you want.

- GET: http://127.0.0.1/users (list all users);
- GET: http://127.0.0.1/users/:id (list a single user, based on its ID);
- POST: http://127.0.0.1/users (creates a new user);
- PATCH: http://127.0.0.1/users/:id (updates some attributes of a single user, based on its ID);
- DELETE: http://127.0.0.1/users/:id (destroy a single user, based on its ID);

Below there is an example of a valid user object which can be used on a POST request:

```json
{
	"user": {
		"name": "Linus Torvald",
		"email": "linus@torvald.com",
		"password": "linus123"
	}
}
```

## Testing the API on Heroku

As I have mentioned above, I have deployed the application on Heroku. To run it there, just change the URI requests above (127.0.0.1) to **guarded-scrubland-77768.herokuapp.com**. It should work the same as locally.

## Redis

As requested, a cache layer was set using Redis. It is available on both GET requests.

To see it implemented, you can make any GET request to the API and check on the terminal in which the rails server is running to verify that no call is made to the database after the second straight request to the same endpoint *(just be careful though, because there is a rule to clear Redis cache keys after create and update methods)*.

**OBS:** I have tried to implement it on Heroku, but I was not able to find a free Redis service in there. So, it is only available on local server.
