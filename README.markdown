# San Pedro

Web engineering challenge presented for Living Social.

Named after the home of the busiest port in the United States.

## Installation

San Pedro is designed to be run locally on the Rails development server with
a PostgreSQL database.

### Prerequisites

- [Ruby 2+](https://www.ruby-lang.org/en/downloads/)
- [PostgreSQL 9+](http://www.postgresql.org/)
- [Bundler](http://bundler.io/)
- [Git](http://git-scm.com/)

For help setting up Rails, see [gorails.com](https://gorails.com/setup/).

### Application Setup

Install the application itself using git:

    git clone https://github.com/klenwell/san-pedro.git san-pedro

Install gems:

    cd san-pedro
    bundle install

### Database

Create your application's postgres database:

    # Use postgres command line interface
    sudo su - postgres
    psql

    # SQL commands
    CREATE USER san_pedro WITH PASSWORD 'san_pedro';
    CREATE DATABASE san_pedro_dev;
    GRANT ALL PRIVILEGES ON DATABASE san_pedro_dev TO san_pedro;
    CREATE DATABASE san_pedro_test;
    GRANT ALL PRIVILEGES ON DATABASE san_pedro_test TO san_pedro;

Setup database:

    bundle exec rake db:setup RAILS_ENV=development
    bundle exec rake db:setup RAILS_ENV=test


## Usage

### Local Server

To start the the local server on port 3000:

    bundle exec rails server -b 0.0.0.0 -p 3000

You should be able to upload files at http://localhost:3000/.


## Tests
All tests:

    bundle exec rake test

Single test:

    bundle exec rake TEST=test/models/purchases_test.rb


## Thoughts and Considerations

### Design Decisions

TBA

### Project Management

I used an Agile approach to organize and task out my project. I tracked my work
using a Trello kanban board:

- https://trello.com/b/HeGGvdbM/san-pedro

User stories were divided between requirements (meeting minimum requirements of challenge)
and enhancements and are labelled accordingly.

### Production Considerations

TBA
