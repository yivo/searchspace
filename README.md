## SEARCH SPACE [searchspace.website](http://searchspace.website)

### About
This project is a website with function to search a set of websites.

At this moment you can only search for handheld devices at [GSMArena.com](http://www.gsmarena.com).

NOTE: This project is used only for testing purposes.

### Implementation
This project is written used latest Ruby on Rails 4.x (4.2.9). I tried to make thing extensible as I could do this for short period of time.

#### Searching
Every search source is represented using `Search::Source`:
* `Search::GSMArenaHandheldsSource`
* `Search::GitHubRepositoriesSource`
* `Search::EbayDronesSource`

and so on.

Search source is responsible for providing search URL and creating dependent objects.

`Search::Criteria` knows everything about search conditions. Every search source must create it's own search criteria like these:
* `Search::GSMArenaHandheldsCriteria`
* `Search::GitHubRepositoriesCriteria`

and so on.

`Search::CriteriaError` inherits from `Search::Error` and used for any search condition error.

`Search::Result` is used to represent one search result. Required data for every search result are:
* source
* name

There is an optional `details` parameter. This data is used for storing any custom data related to search result.

`Search::Result` objects are created by `Search::ResultsBuilder`. 

`Search::ResultsBuilder` accepts parsed data returned by search request like ruby hash (parsed from JSON response) or nokogiri document etc. Builder only returns array of `Search::Result`.
Every source must define own builder like `Search::GSMArenaHandheldsResultsBuilder`.

And the main player is `Search::Performer`. This class responds for initiating search request and connecting all other classes together. There is build in support for HTML and JSON responses.

#### Getting details for search result
It is possible to show details for some search result. 

For example, you found mobile phone and would like to know specs. Click "Show specs" and the table will known specs will appear.

Every source can create their own details loader class. 

For example, `GSMArenaHandheldsResultDetailsLoader` takes page URL, loads it and parses specs if possible.

### Testing
For this project I used RSpec for unit and Capybara for functional testing.

I tried to test as mush as possible. The written tests are not perfect although.

I used TravisCI for testing purposes and for deployment from master.

### Problems
There are some problems related to performance.

#### More search sources = slower response and bigger chance of failure
It is possible to add new sources. But possibly you will discover a performance problems.

Why? More search sources = more HTTP request to do. The search requests are issues sequentially. The system is designed so if one of them fails the request will fail too. 

For two or three search sources it will be suitable but for more it won't, I think.

There are some solutions for this problem.

##### Using background processing (e.g. Sidekiq) and Web sockets
When used submits a search we can queue a job to search all sources. When job will be finished background worker will submit results to user through Web sockets. This probably will not speed up search for user but will do great job for freeing server resources. Also we can split search by sources so every search in every source will be performed in separate background job. This will probably increase system stability.

##### Submitting separate search requests for every source
This will probably upgrade application responsiveness for user but requires code refactoring.

Also this method will not be effective for big amount of search sources (method requires big amount of running application because each search request will act as blocking operation).

##### Issuing every request in separate thread
This is possible with ruby but requires code refactoring and good understanding of subject.

### Initial project structure
Generated via `bundle exec rails new searchspace --skip-active-record --skip-spring --skip-turbolinks --skip-test-unit --skip-bundle --skip-javascript`
