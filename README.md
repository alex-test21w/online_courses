# OnlineCourses

## API documentation:
```
https://secure-shore-57650.herokuapp.com/api/docs
```

# Setup instructions
Copy project
```bash
git@github.com:alex-test21w/online_courses.git
```
Copy database config
```bash
cp config/database.yml.template config/database.yml
```
Add to config/database.yml username and password for MySQL DB
Install gems
```bash
bundle install
```
Setup database
```bash
bundle exec rake db:setup
```
Start rails server
```bash
bundle exec rails s
```
