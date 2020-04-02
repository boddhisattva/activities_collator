# Activities Collator

## About

This is a program to collect & search events information for our website from other web sources. The web sources selected for this project are:
* [Co-Berlin events](https://www.co-berlin.org/en/calender)
* [Berghain events](http://berghain.de/events/)

## Demo application

This project has been prepared for ease of deployment and one can see a working version of the project on: https://activities-collator.herokuapp.com/. A demo screenshot of the
working app is available [here](#screenshot-of-working-application)


Please note: With the help of the Heroku Scheduler add on, this project is configured to extract the latest events from the above
web sources on a regular basis, this way new events will be made visible on https://activities-collator.herokuapp.com/

## Code Related Design Decisions

* The key concepts related to the problem domain are `Event`, `WebSource`, `Scraper` and `Parser`

* At appropriate places database and application level constraints are added to ensure we have data consistency

* Many single column indexes have been added to facilitate faster database lookups since a user can search events based on different criteria.

* Since in web scraping one can get data from the web and store them into a local database, a Scraper **has a** parser to make sense of the constituent data parts and hence I've attempted to use **composition** here

* Since parsers can have some common functionality when it comes to parsing data, I've extracted the common code into a base class and have **used Template
Method Design pattern** here. This is also done with the intention to **make the code open closed** so that if new parsers have to be added the cost of change
for implementing new parsers to for instance parse info from newer web sources can be kept to a minimum

* Appropriate **exception handling is added** in different parts of the code base like when creating events or websources and an **attempt has been made to log them** so that in a production environment one can actually use that info to better understand the related errors and take appropriate measures to address them.

### Areas of Improvement

* Kindly note that the current implementation has been scoped to get new events from different web sources mentioned above. If existing events are updated
from the above mentioned web sources, those updates won't currently reflect as part of the code implemented in this project. I've intended to implement a
basic version of the requirement and I definitely can admit, updating existing events if updated in original web sources is surely worthwhile.

* One can improve the code further by collating and creating the relevant events through background jobs

## Usage

### Dependencies
* Ruby 2.7.0
* Please refer to the Gemfile for the other dependencies

### Setup
* Run `bundle` from a project's root directory to install the related dependencies.

### Running the program
In order to be able to collate & search through various events in the program, one would have to first scrape the relevant events
information from the above mentioned web sources. Below are steps involved for one to be able to get up & running with this program.

From the project root directory:
* Create the Database Schema with: `rake db:create` and `rake db:migrate`
* Scrape events info from the above mentioned web sources with the command: `rake scraper:scrape`
  * The scraper rake tasks prints a summary of the scraped results to command line. If all the page events have been scraped
  successfully the errors count will be 0, else one would get to see a count on the total number of errors.
* Start the rails app with: `rails s`

One should now be able to see all the events on the home page and search through different filter criteria like
* Web Source
* Event start and finish dates
* Simple partial text search on title

### Debugging

* For ease of debugging in case error count is greater than 0 when running `rake scraper:scrape` through the command line console,
 one can see errors with detailed reasons that prevented successful creation of events in the `development.log` through the command `tail -f log/development.log`

### Running the tests
* One can run the specs from the project's root directory with the command `rspec`

#### Program Output when running the Scraper rake task(to get events from the web sources & create them in the database)

* Below are two cases of sample program output on the command line console run from the projects root directory using the command `rake scraper:scrape`

  * Case 1: Successful scraping without any errors

    ```
      *********
      Scraped results summary for websource: https://www.co-berlin.org/en/calender

      Total number of errors: 0
      *********

      *********
      Scraped results summary for websource: http://berghain.de/events/

      Total number of errors: 0
      *********

    ```

* Case 2: Scraping has errors

    ```
      *********
      Scraped results summary for websource: https://www.co-berlin.org/en/calender

      Total number of errors: 9
      *********

      *********
      Scraped results summary for websource: http://berghain.de/events/

      Total number of errors: 18
      *********
    ```

#### Screenshot of working application

![Activities Collator](http://i.imgur.com/MWxGIpk.png "Activities Collator")



