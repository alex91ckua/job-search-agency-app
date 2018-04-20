# Job Search App

This is simple Job Search rails application where admin can post jobs for different companies and users can apply to such jobs.

Features

* admin can create companies
* admin can create jobs for companies
* user can apply for jobs and include cover letter file
* admin can view candidates at /admin panel (ActiveAdmin gem)
* company can receive job alerts once someone applied to their job post
* blog functionality

Main gems

* carrierwave - as file uploader
* active admin - simple admin panel
* devise - admin login

Installation

```
git clone https://github.com/alex91ckua/job-search-agency-app
bundle
rails db:create db:migrate
rails s
```

Additionally you can add ActiveAdmin user like this

```
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
```