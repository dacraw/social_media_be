# Setting up local database
- By default, Postgres will install with the `postgres` user with password `postgres`. If this is not the case, **you must ensure that your local Postgres database has a user `postgres` with the password `postgres` in order to develop this app locally.** 

# Setup
- Run `rails db:setup` and `rails db:migrate` to set up database
- Run `bundle install` to install Gems
- Run `rails s` to start Rails server

# API
## GET `/users/:id/timeline`
This single endpoint provides the given user's timeline, paginated 7 results at a time and sorted reverse chronologically.

Example:

GET `/users/4/timeline` - will provide the first 7 timeline items for the user \
GET `/users/4/timeline?page[page]=2` - will provide the second page of results \
etc... 

This endpoint uses the Ruby gem [`Pagy`](https://github.com/ddnexus/pagy) to paginate results, due to its exceptional performance compared to native Rails pagination. The response from this endpoint will include a `"links"` key that will contain information regarding next available page. For example:

```
{
  "data"=> [...],
  "links"=> {
    "first"=>"/users/184/timeline?page%5Bpage%5D=1",
    "last"=>"/users/184/timeline?page%5Bpage%5D=2",
    "prev"=>"/users/184/timeline?page%5Bpage%5D=1",
    "next"=>"/users/183/timeline?page%5Bpage%5D=2"
  }
}
```

Please note that `"next"` presents the route for the next page of results. If `"next"` is `null`, then there are no more results to show. Please also note that when sending the request you must format the next page number as such: `page[page]=PAGE_NUMBER`. In the example above, the brackets in the url are escaped (i.e. `page%5Bpage%5D=1`). You should be able to rely on the `"next"` route provided by the response instead of passing number manually, but of course this is important to note in case you are expecting a specific page of results immediately (e.g. if you wish to visit the second page of results instead getting the `"next"` value by visiting the initial `/users/:id/timeline` route).




