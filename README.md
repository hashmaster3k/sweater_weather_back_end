# Sweater Weather Backend API
![](https://img.shields.io/badge/Rails-5.2.4.3-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=2bbc8a)
![](https://img.shields.io/badge/Ruby-2.5.3-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=2bbc8a)
![Badge](https://marcgrimme.github.io/simplecov-small-badge/badges/coverage_badge_total.svg)

## Summary

  - [Getting Started](#getting-started)
  - [Setting Up API](#setting-up-api)
  - [Testing](#running-tests)
  - [Deployment](#deployment)
  - [Endpoints](#endpoints)

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

This project was built using ruby version 2.5.3 and rails 5.2.4.3. Ensure that you either install these versions or change the versions in the Gemfile.

### Prerequisites

This project uses postgresql for database management. Please download the [Postgres.app](https://postgresapp.com/downloads.html) and follow the documentation to also install the CLI tools.

In addition to the standard rails gems, we used the following gems:
```rspec```, ```simplecov```, ```pry```, ```shoulda-matchers```, ```webmock```, ```faraday```, ```figaro```, ```jsonapi-serializer```, ```bcrypt```, and ```rubocop```.

- [RSpec](https://github.com/rspec/rspec-rails) - Test Suite
- [SimpleCov](https://github.com/simplecov-ruby/simplecov) - Test Coverage
- [Pry](https://github.com/pry/pry) - Runtime Dev Console
- [Shoulda Matchers](https://github.com/thoughtbot/shoulda-matchers) - Additional Testing Tools
- [WebMock](https://github.com/bblimke/webmock) - API Testing Tool
- [Faraday](https://github.com/lostisland/faraday) - API Consumption
- [Figaro](https://github.com/laserlemon/figaro) - API Key Protection
- [JSON:API-serializer](https://github.com/jsonapi-serializer/jsonapi-serializer) - serialization of data
- [BCrypt](https://github.com/codahale/bcrypt-ruby) - Password Protection for Authentication
- [RuboCop](https://github.com/rubocop-hq/rubocop) - Linter (optional)

Please follow the documentation for each gem for proper installation and functionality. Note: Most needed files/code are already added (rails_helper, spec_helper, etc.)

### Installing

If you plan on making your own changes and intend to push it back up, fork this repository then clone it into your directory of choice. In the main project directory, delete the file Gemfile.lock. Then, in your terminal, from the project directory run ```bundle install``` to install all the needed gems.

To setup the database from your terminal, run the following commands:

```
rails db:create
```
```
rails db:migrate
```
```
rails db:seed
```

This will create your database, migrate the needed resources then seed the database with starting data.

## Setting up API

Multiple APIs were used for this project. You may choose your own APIs, however some refactoring may be needed based on the returned results of said API. The APs used were:

- [MapQuest API](https://developer.mapquest.com/)
- [OpenWeather](https://openweathermap.org/)

Refer to the Figaro gem documentation to create your own ```application.yml``` and place your key as follows:

```yml

MAP_URL: 'ENTER URL HERE'
MAP_API_KEY: 'ENTER API KEY HERE'

WEATHER_URL: 'ENTER URL HERE'
WEATHER_API_KEY: 'ENTER API KEY HERE'

```

## Running Tests

From your main directory in the command line, type ```bundle exec rspec```. This will run all tests located in the /spec directory. If any errors or failures occur please create and issue.

To run specific test files, include the file path.
```
bundle exec rspec spec/facades/map_facacde_spec.rb
```

## Deployment

Before full cloud based deployment, check that the web app is working locally by opening a new tab in terminal and run the command ```rails s```. This will run a local server which you can connect to. Type ```localhost:3000``` into your web browsers address bar and hit enter. You should see the root page with a welcome message and a login field.

Cloud deployment was done with [Heroku](https://heroku.com/). Visit the ["getting started with rails"](https://devcenter.heroku.com/articles/getting-started-with-rails5) on how to deploy the web app to Heroku.

## Endpoints

### ```GET /forecast``` - weather for location

Returns weather data in JSON format based on location given. Enter location as name/value pair in parameters as shown below in the example.

Example request:
```
GET /api/v1/forecast?location=denver,co
Content-Type: application/json
Accept: application/json
```

Example response:
```json
{
    "data": {
        "id": null,
        "type": "forecast",
        "attributes": {
            "current_weather": {
                "datetime": "2020-11-07T23:49:51.000Z",
                "sunrise": "2020-11-07T13:36:02.000Z",
                "sunset": "2020-11-07T23:51:17.000Z",
                "temperature": 67.84,
                "feels_like": 62.26,
                "humidity": 24,
                "uvi": 3.29,
                "visibility": 6.2,
                "conditions": "broken clouds",
                "icon": "04d"
            },
            "daily_weather": [
                {
                    "date": "2020-11-07",
                    "sunrise": "2020-11-07T13:36:02.000Z",
                    "sunset": "2020-11-07T23:51:17.000Z",
                    "max_temp": 70.09,
                    "min_temp": 56.91,
                    "conditions": "overcast clouds",
                    "icon": "04d"
                },
                {
                    "date": "2020-11-08",
                    "sunrise": "2020-11-08T13:37:11.000Z",
                    "sunset": "2020-11-08T23:50:18.000Z",
                    "max_temp": 59.67,
                    "min_temp": 48.34,
                    "conditions": "light rain",
                    "icon": "10d"
                },
                {
                    "date": "2020-11-09",
                    "sunrise": "2020-11-09T13:38:21.000Z",
                    "sunset": "2020-11-09T23:49:21.000Z",
                    "max_temp": 44.6,
                    "min_temp": 30.58,
                    "conditions": "broken clouds",
                    "icon": "04d"
                },
                {
                    "date": "2020-11-10",
                    "sunrise": "2020-11-10T13:39:30.000Z",
                    "sunset": "2020-11-10T23:48:25.000Z",
                    "max_temp": 47.05,
                    "min_temp": 31.06,
                    "conditions": "clear sky",
                    "icon": "01d"
                },
                {
                    "date": "2020-11-11",
                    "sunrise": "2020-11-11T13:40:40.000Z",
                    "sunset": "2020-11-11T23:47:32.000Z",
                    "max_temp": 45.39,
                    "min_temp": 33.66,
                    "conditions": "scattered clouds",
                    "icon": "03d"
                }
            ],
            "hourly_weather": [
                {
                    "time": "23:00:00",
                    "wind_speed": "17.72 mph",
                    "wind_direction": "from S",
                    "conditions": "broken clouds",
                    "icon": "04d"
                },
                {
                    "time": "00:00:00",
                    "wind_speed": "7.76 mph",
                    "wind_direction": "from SW",
                    "conditions": "broken clouds",
                    "icon": "04n"
                },
                {
                    "time": "01:00:00",
                    "wind_speed": "11.59 mph",
                    "wind_direction": "from S",
                    "conditions": "few clouds",
                    "icon": "02n"
                },
                {
                    "time": "02:00:00",
                    "wind_speed": "18.66 mph",
                    "wind_direction": "from SW",
                    "conditions": "broken clouds",
                    "icon": "04n"
                },
                {
                    "time": "03:00:00",
                    "wind_speed": "18.61 mph",
                    "wind_direction": "from SW",
                    "conditions": "scattered clouds",
                    "icon": "03n"
                },
                {
                    "time": "04:00:00",
                    "wind_speed": "12.64 mph",
                    "wind_direction": "from S",
                    "conditions": "scattered clouds",
                    "icon": "03n"
                },
                {
                    "time": "05:00:00",
                    "wind_speed": "12.71 mph",
                    "wind_direction": "from S",
                    "conditions": "few clouds",
                    "icon": "02n"
                },
                {
                    "time": "06:00:00",
                    "wind_speed": "11.21 mph",
                    "wind_direction": "from S",
                    "conditions": "few clouds",
                    "icon": "02n"
                }
            ]
        }
    }
}
```
