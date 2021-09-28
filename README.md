# Event Manager

A Web Application built on Ruby on Rails which imports the users and events data from CSV and update the RSVP of user for each event accordingly in case there is an overlap.

# Installation Steps

## Step 1 - Install prerequisites

Install Ruby-3.0.0

      $ rvm install 3.0.0

## Step 2 - Clone the Repository

      $ git clone https://github.com/bprateek10/event_manager.git
      $ cd event_manager

## Step 3 - Bundle

Run following commands on terminal in your root directory

      $ gem install bundler
      $ bundle install

## Step 4 - Create database

Create database.yml file in config folder and paste following into it with your porstgres credentials

      default: &default
        adapter: postgresql
        pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
        username: #{YOUR POSTGRES USERNAME}
        password: #{YOUR POSTGRES PASSWORD}
        timeout: 5000
      development:
        <<: *default
        database: event_manager_development
        host: localhost
      test:
        <<: *default
        database: event_manager_development_test
        host: localhost
      production:
        <<: *default
        database: event_manager_development_production
        adapter: postgresql
        host: localhost
        pool: 5
        username: postgres
        password: postgres
        timeout: 5000

Save the changes.

Now in terminal run following commands

      $ rails db:create
      $ rails db:migrate
      $ rails db:seed
