# Contacts App

A simple Contacts application built with Ruby on Rails. Similar to "Contacts" on most phone, this application enables you to search and manage your contacts list easily.

## Usage

### Step 1: Install all prerequisites

- Ruby on Rails 5.x and all its prerequisites. Please refer to [official guide](http://guides.rubyonrails.org/getting_started.html).
- PostgreSQL server. If you have it installed, start by running
```
sudo service postgresql start
```

### Step 2: Clone this project
```
cd DESIRED_DIRECTORY
git clone https://github.com/weihien90/ror-contacts.git
```

### Step 3: Setup
Update database credentials
```
# config/database.yml

development:
  adapter: postgresql
  encoding: unicode
  template: template0
  database: DATABASE_NAME
  username: USERNAME
  password: SECRET
```
Create and migrate the database schema (make sure your user have CREATEDB permission)
```
rails db:create db:migrate
```
Install all required gems
```
bundle install
```

### Start server
```
rails s
```
