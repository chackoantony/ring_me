# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
  ruby 3.2.2

* System dependencies
  gem 'twilio-ruby
  ngrok

* Configuration
  Export following env vars.
  - export TWILIO_ACCOUNT_SID=ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 
  - export TWILIO_AUTH_TOKEN=your_token_here
  - export TWILIO_PHONE_NUMBER="+15555550123"
  - export PUBLIC_URL=ngrok_url_here

* Database creation
   rake db:create

* Database initialization
  rake db:migrate

* How to run the test suite
  bundle exec rspec

* Deployment instructions

  Go through following steps to run the application in development mode.

  - migrate database - rake db:create & rake db:migrate
  - Setup Twilio account & export env vars as specficed above
  - run rails server - rails s
  - run ngrok tunneling - ngrok http 3000
  - Visit home page (/) and follow the instructions.

* Further imporvement suggestions
  Here I am using two differrent status fields (status, twilio_status) to seperate status updates. Currently we are only recording twilio status 'queued'. But we can make use of Twilio webhooks to update further call statuses. Also by using webssocket we can update the realtime status in front end.  
