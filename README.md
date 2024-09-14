# Posts App w/ User Activity Feed (including some Github public events)

#### Important Note About Database:
This App uses Postgresql, so please be sure to install it locally if you do not have it:
- Linux:
  - `sudo apt update`
  - `sudo apt install postgresql`
- macOS: Please refer to [PostgresQL](https://www.postgresql.org/download/macosx/) Documentation in order to install on MacOS

By default, Postgres installation should include the `postgres` user with password `postgres`. If this is not the case, **you must ensure that your local Postgres database has a user `postgres` with the password `postgres` in order to develop this app locally.** 

# Setup
- Run `rails db:setup` and `rails db:migrate` to set up database
- Run `bundle install` to install Gems
- Run `rails s` to start Rails server

# API
## Signup & Authentication
Users must be authenticated using a Json Web Token (JWT), which will be passed under the key `"token"` in the responses of the `/login` route for existing users or `/sign_up` for new users.

Example response from either of the authentication routes:

```
{
  "message":"User saved",
  "user":{...},
  "token":"JWT.TOKEN.HERE"
}
```

Please store the JWT from the response inside the `Authorization` header of requests to other API endpoints in the app (i.e. `"Authorization": "Bearer TOKEN.GOES.HERE"`)

### POST `/signup`
Creates a user in the database and returns their JWT in the response

**Required Params:** `{ user: { name:string, email:string, password:string } }`

### POST `/login`
Login the user and return a JWT to be used in future API requests to non-authorization routes.

**Required Params:** `{ authentication: { email:string, password:string } }`

## Posts
These routes are necessary for retrieving posts in the database. Please note that a valid JWT must be passed in the `Authorization` header for these routes. Although these routes could be publically available, they are protected in order to encourage user signup.

### GET `/posts`
Retrieve all posts in the database, which are paginated 7 at a time.

**Response Values**:

```
{
  "data":[{
      "id":integer,
      "title":string,
      "body":string,
      "user_id":integer,
      "posted_at":string,
      "created_at":string,
      "updated_at":string
  }],
  "links": {
    "first":string, // route to first page of results
    "last":string,  // route to last page of routes
    "prev":string | null,  // route to previous page of results, or null if there is no previous page
    "next":string | null  // route to next page of results, or null if there are no more pages to show
  }
}
```

Please see **Navigating Pagination** for information on retrieving additional pages of results.

### GET `/post/:id`
Retrieve a single post with the provided id param.

**Response Values**:

```
{
  "id":integer,
  "title":string,
  "body":text,
  "user_id":integer,
  "posted_at":string,
  "created_at":string,
  "updated_at":string,
  "user_average_rating":float | null, // the average rating of the post's user
  "post_user_name":string // the name of the user who created the post
}
```

### POST `/posts`
Create a new post.

**Required Params:** `{ post: { user_id:integer, title:string, body:text } }`

**Response Values:** 

```
{
  "id":integer,
  "title":string,
  "body":text,
  "user_id":integer,
  "posted_at":string,
  "created_at":string,
  "updated_at":string  
}
```

## Comments
Comments belong to a Post, and the routes must all include the `post_id` param value of the associated post.

### GET `/posts/:post_id/comments`

**Response Values:**

```
[{
  "id":integer,
  "user_id":integer,
  "post_id":integer,
  "message":text,
  "commented_at":string,
  "created_at":string,
  "updated_at":string
}]
```

### GET `/posts/:post_id/comments/:id`
Retrieve a given post comment for the provided `post_id` and comment `id`.

**Response Values:**

```
[{
  "id":integer,
  "user_id":integer,
  "post_id":intger,
  "message":text,
  "commented_at":string,
  "created_at":string,
  "updated_at":string
}]
```

### POST `/posts/:post_id/comments`

Creates a new comment for a given `post_id`.

**Required Params:** `{ comment: { message:string} }`

**Response Values:**

```
{
  "id":2,
  "user_id":integer,
  "post_id":integer,
  "message":string,
  "commented_at":string,
  "created_at":string,
  "updated_at":string,
  "user_average_rating":float | null // the commenter's average rating
}
```

## User Ratings

### POST `/user_ratings`
Create a user rating for a user.

**Required Params:** `{ user_rating: { rater_id:integer, user_id:integer, rating:integer } }`

**Response Values:**

```
{
  "id":integer,
  "user_id":integer,
  "rater_id":integer,
  "rating":integer,
  "rated_at":string,
  "created_at":string,
  "updated_at":string
}
```

## User Timeline (Activity Feed)

### GET `/users/:id/timeline`
This single endpoint provides the given user's timeline, paginated 7 results at a time and sorted reverse chronologically.

**Response Values:**

```
{
  "data":[{
    "id":integer,
    "timelineable_type":string, // the object type associated with this timeline event, such as Post or User
    "timelineable_id":integer, // the id of the timelineable object
    "event":string, // the name of the timeline event, such as "create_post"
    "created_at":string,
    "updated_at":string,
    "user_id":integer,
    "message":string, // the message associated with the event, such as "Pushed 2 commits to torvalds/linux master"
    "date":string
  }],
  "links": {
    "first":string, // the route to the first page of paginated results, e.g. "/users/4/timeline?page%5Bpage%5D=1"
    "last":string, // the route to the last page of results, e.g. "/users/4/timeline?page%5Bpage%5D=5"
    "prev":strig | null, // the previous page of results
    "next":string | null // the route leading to the next page of results, if present. e.g. "/users/4/timeline?page%5Bpage%5D=2"
  }
}
```

Please see **Navigating Pagination** for information on retrieving additional pages of results.

## Navigating Pagination
The `/posts` and `/users/:id/timeline` routes are paginated, and **it is recommended that you rely on the `"next"` value provided in the response instead of passing a number manually, in order to more easily implement infinite scroll.** If you are trying to access a specific page of results, you must pass in the `pages[page]=NUMBER` param. 

```
# GET `/users/4/timeline`
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

If `"next"` is `null`, then the last page of results has been reached. If you enter a `page[page]` param with a page number that exceeds the total number of pages, the last page of results will be returned.

# Errors
Errors will be returned in the format `{ errors: { message:string | array }`






