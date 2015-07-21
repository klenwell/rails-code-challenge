# San Pedro
Web engineering challenge presented for Living Social.

Named after the home of the busiest port in the United States.

## Installation
San Pedro is designed to be run locally on the Rails development server with
a PostgreSQL database.

### Prerequisites
Developed and tested with the following components:

- [Rails 4.2.3](http://rubyonrails.org/)
- [Ruby 2.2.1](https://www.ruby-lang.org/en/downloads/)
- [PostgreSQL 9.1.18](http://www.postgresql.org/)
- [Bundler 1.10.5](http://bundler.io/)
- [Git 1.7.9.5](http://git-scm.com/)

For help setting up Rails, see [gorails.com](https://gorails.com/setup/).

### Application Setup
Install the application itself using git:

    git clone https://github.com/klenwell/san-pedro.git san-pedro

Install gems:

    cd san-pedro
    bundle install

### Authentication
Authentication was implemented using the [OmniAuth Google OAuth2 gem](https://github.com/zquestz/omniauth-google-oauth2) and requires a Google account
to authentice with the app. Any Gmail account should work.

It also requires the following additional configuration. To set up an API key and
authorize your application, follow these steps:

1. Log into your [Google Developer's Console](https://console.developers.google.com/).
2. Select an existing project (or create a new one if necessary).
3. In sidebar at left, click **APIs & auth**.
4. Enable API for both Contacts API and Google+ API.
5. In sidebar, click **Consent Screen** and configure consent screen for users.
6. In sidebar, click **Credentials** then under OAuth, click **Create new Client ID**
7. On modal screen, enter following options:
  - Application Type: web application (should be default)
  - Under Authorized Javascript origins, your test URL: e.g. `http://localhost:3000/`
  - Under Redirect URIs: `http://localhost:3000/auth/google_oauth2/callback`
8. Click **Create Client ID** button.

You will be redirected to Credentials screen where you can now obtain the `Client ID`
and `Client Secret` tokens you will need for your app.

Note: You would need to add any additional URIs for staging or production servers.

Finally, create the following file at `config/app_environment_variables.rb` to include your tokens:

    # Google API Keys for omniauth-google-oauth2 gem.
    # See Google Developers Console to manage.
    ENV["GOOGLE_CLIENT_ID"] = "YOUR_CLIENT_ID_HERE"
    ENV["GOOGLE_CLIENT_SECRET"] = "YOUR_CLIENT_SECRET_HERE"

**Note: do not commit that file to your repository.** It is already listed in the `.gitignore` file.

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

You should be able to upload files at [http://localhost:3000/](http://localhost:3000/).


## Tests
All tests:

    bundle exec rake test

Single test:

    bundle exec rake TEST=test/models/purchases_test.rb


## Thoughts and Considerations
### Design Decisions

- Designed application to meet minimum requirements of application while leaving room for progressive improvements.
- To expedite development, invalid files fail fast with terse messaging. Upload logic set up to enable more expressive feedback with minimal refactoring if desired.
- Organized data into Purchase, Merchant, Product, and Purchaser model. Adapted model names and other terminology from project spec and provided sample file.
- Chose SmarterCSV because I've used it before and it provides a friendly interface.
- Used MiniTest as a matter of habit.
- Coding style and practices generally reflect those promoted at my current organization.

### Project Management
I used an Agile approach to organize and task out my project. I tracked my work
using a Trello kanban board:

- [https://trello.com/b/HeGGvdbM/san-pedro](https://trello.com/b/HeGGvdbM/san-pedro)

User stories were divided between requirements (meeting minimum requirements of challenge)
and enhancements and are labelled accordingly.

### Timesheet
In total, I spent about 5 hours completing the minimum requirements of the exercise:

    Planning                        0.5 hours
    Project Setup                   0.5
    Upload Form                     3.0
    Summary/Review                  1.0
    ----------------------------
    Total                           5.0 hours

I spent another 5-6 hours in total implementing a working authentication feature integrating
Google's OAuth 2.0 API which, according to [their
documentation](https://developers.google.com/identity/protocols/OpenIDConnect)
"conforms to the OpenID Connect specification, and is OpenID Certified":

    Research/Planning               0.5 hours
    Failed 1st Try                  1.0
    Additional Research/Planning    0.5
    Google Auth Implementation      3.0
    Summary/Review                  0.5
    ----------------------------
    Total                           5.5 hours

### Production Considerations
A list of potential enhancements can be found in the "To Do" list on my Trello board:

- [https://trello.com/b/HeGGvdbM/san-pedro](https://trello.com/b/HeGGvdbM/san-pedro)

To transform this into a production-ready site, I would consider the following points:

- Subject application to appropriate security analysis.
  - Is authentication implemented correctly?
  - Is upload vulnerable to exploits?
- Add a file/upload model to track uploads and stop duplicates.
- Provide more detailed error messages to identify issues with reject files.
- Delegate processing to backend queues should upload files be too large for single request.
- Restructure data?
  - Extra data normalization may be overkill if new data is going to be transformed and reloaded by some secondary process.
  - Denormalization may also be warranted depending the size of data and performance demands on application.
- Use a different data store?
- Refactor data parser to be more tolerant or flexible, perhaps as its own class or library.
- Solicit suggestions for improved interface.
