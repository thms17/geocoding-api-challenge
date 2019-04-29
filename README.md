# Geocoding API Challenge

This is my solution to the geocoding challenge. If you run this rails --api app locally, it will accept GET requests holding an address query like for example "Hamburg" or "Bristolstr. 5, 13349 Berlin" and respond with the coordinates of the given address.
## Getting Started

The app is built with [rails](https://github.com/rails/rails). You will need to install [rails](https://github.com/rails/rails) to use it.
In order to get this program running on your computer, download this repository and move to its folder. Run ```bundle install```, ```rails routes``` and ```rails db:migrate``` in your terminal. Afterwards, you should be able to launch a local server using ```rails s```.


## Running the tests

Run ```rspec``` in your terminal to run all tests. There are tests on the user model and on the coordinates controller.

## Description

I will walk you through the process of creating this app and the design decisions I made along the way.
I started of with creating a rails app with ```Rails new geocoding-api-challenge --api```. This will do a bunch of things that suit the purpose of this app. The --api option on a new rails project will remove some of the unnecessary luggage that comes with a full-blown rails app like assets or views. Since we will not need any of those, we will leave them out to keep the program as lean as possible. I added [RSpec](https://github.com/rspec/rspec-rails) to the gemfile.
First, I created a coordinates controller alongside the associated test file. This controller is where the main logic will be written. The tests check for invalid and non-existent queries as well as for the correct answers to a city (Berlin), an address (Dessauer Str. 28) and a sight (Checkpoint Charlie), because these are the three different kinds of requests that can be made (sidenote: I had to let all query tests sleep for 1 second because the API will not allow more than one request per second).
The controller has two methods 'index' and 'authenticate'. The index method will call LocationIQs API endpoint with whatever is passed to it in the params. Thus I created the route
```
get '/coordinates/:query', to: 'coordinates#index', constraints: { query: /[^\/]+/ }
```
This way a query can be passed right in the URL. I needed to overwrite the constraints for this in order to be able to accept dots as in Bristolstr. 5. The response in JSON format will be parsed and afterwards rendered again as a JSON, displaying latitude and longitude of the given address. If the API throws a "400 Bad Request" or a "404 Not Found" the app won't break and will display the error messages in JSON format.
The authenticate method will be called before the index action. This will make sure that only authorized users have access to the API endpoint. To create authorization tokens I needed to create a user model and a test file for it. This model has the sole purpose of assigning a unique token before creating a new user instance and save it in the database. The tests here check that a user is saved successfully and that a user gets a token assigned.
Right now, the before_action :authenticate is commented out. If you want to see the authorization take place, simply remove the '#'. You will need to create a new user in the console and take the token that is assigned to the user. You will need to put this token in the header of the GET request (for example using [postman](https://www.getpostman.com/)). Even though this works fine in manual testing, I had a hard time passing the Authorization token in the header with RSpec, even though I spent quite some time looking for a solution.

