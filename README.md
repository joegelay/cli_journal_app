# CLI Journal App 

A simple CLI-based journal app that is easy to use and fast to run.  

## Description

CLI Journal App has full CRUD functionality. 
- A user can submit journal entries throughout the day, read prior journal entires, udpate entries, and delete past entries. 

## Getting Started

### Gems
```
gem "pry", "~> 0.12.2"
gem "activerecord", "~> 6.0"
gem "sinatra-activerecord", "~> 2.0"
gem "rake", "~> 13.0"
gem "sqlite3", "~> 1.4"
gem "require_all", "~> 3.0"
gem "tty-prompt", "~> 0.20.0"
```
### Executing program

* Fork and clone the CLI Journal App repo
* Run ``` bundle install ```
* Run ``` rake db:migrate ```
* Run ``` rake db:seed ```
* Run ``` ruby runner.rb ```

## Authors

Joe Gelay  
[@joegelay](https://github.com/joegelay)

Josh Couper 
[@jcouper](https://github.com/jcouper)

## License

This project is open to the public. No license is required for use.