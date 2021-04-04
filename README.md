# FUN COURSES API

This is an API build with Rails 6.1.1. for the final capstone project of the technical curriculum in Microverse. You can find the code of the Fun Courses react and redux front-end at this [link](https://github.com/javierbotero/FunCourses/tree/master) that uses this API which is capable to store courses, users, friendships, subscriptions, comments, tokens, and favorites. Feel free to fork this project and make your API up and running. If you want to see the JS fetch requests in action are in this two links: [here](https://github.com/javierbotero/FunCourses/blob/feature/src/actions/retrievals.js) you will find the requests when the app starts and [here](https://github.com/javierbotero/FunCourses/blob/feature/src/actions/interactions.js) queries to persist when the user request a subscription, accept or accept a friendship to say a few.

## Live Preview

[Fun Courses]()

![app image](./readme_pictures/pic.png)

## Built With

- Rails 6.1.1
- Ruby 2.7.2p137

## Getting started

To start with the project:

1. Install Ruby and Ruby on Rails in your machine, it is recommended to use the same versions that use this project.
2. Fork this repository.
3. Run `bundle install` inside the folder where the app lives.
4. Run rails db:create
5. Because this project relies on Cloudinary vendor for uploading pictures or media to the cloud in all environments, you need to have an account in Cloudinary to run successfully and upload any picture in the local environment. You can find more information about Cloudinary [here](https://cloudinary.com/documentation/rails_integration), and about active storage [here](https://edgeguides.rubyonrails.org/active_storage_overview.html#setup).
6. This project uses environment variables that provide the credentials to access to Cloudinary, because this is sensitive information that should not be uploaded to source control it is recommended that you set up these variables in your environment named the same as in the file config/initializers/cloudinary.rb.
7. Run the migration to database
    - rails db:migrate
8. Run the rails server
    - rails server


## Instructions

### Requests

This is an example of a request to create a new course using js fetch() in a local development using port 3000:

```
fetch('https//localhost:3000/courses/create', {
  method: 'POST',
  mode: 'cors',
  cache: 'no-cache',
  credentials: 'same-origin',
  headers: new Headers({
    'Content-Type': 'application/json',
  }),
  redirect: 'follow',
  referrerPolicy: 'no-referrer',
  body: JSON.stringify({
    current_user_id: 7,
    current_user_password: "password",
    token_id: 25,
    token: "sometoken",
    user: {
      link: 'link',
      provider: 'provider',
      title: 'title',
      content: 'the content',
      status: 'Closed',
      dates:, '2021-03-25T00:00:00.000Z 2021-03-29T00:00:00.000Z '
    }
  }),
})
```

### Generate your Token

To create your token just make a curl request like this:

```
curl --request POST https://floating-earth-85150.herokuapp.com/tokens
```

### Endpoints

Using the main url https://floating-earth-85150.herokuapp.com/ you can go to:

POST   /signup(.:format)

POST   /user(.:format)

POST   /courses(.:format)

POST   /courses/create(.:format)

POST   /user/friends(.:format)

PATCH  /users/:id(.:format)

PUT    /users/:id(.:format)

DELETE /users/:id(.:format)

PATCH  /courses/:id(.:format)

PUT    /courses/:id(.:format)

DELETE /courses/:id(.:format)

POST   /friendships(.:format)

PATCH  /friendships/:id(.:format)

PUT    /friendships/:id(.:format)

DELETE /friendships/:id(.:format)

POST   /subscriptions(.:format)

PATCH  /subscriptions/:id(.:format)

PUT    /subscriptions/:id(.:format)

DELETE /subscriptions/:id(.:format)

POST   /favorites(.:format)

DELETE /favorites/:id(.:format)

POST   /comments(.:format)

PATCH  /comments/:id(.:format)

PUT    /comments/:id(.:format)

DELETE /comments/:id(.:format)

POST   /tokens(.:format)

DELETE /tokens/:id(.:format)

To see which proper payload should be sent, just check out the controllers which handle the requests. Remember that `params` are the data that you need to send out in the fetch inside the body as seen in the example js fetch request example above. Please pay special attention to the application_controller.rb file where the methods `authenticate` and `authenticate_token` take through params the information about user and token to be able to continue the request to the controllers. These are the routes of the controller files:

./app/controllers/application_controller.rb,
./app/controllers/comments_controller.rb,
./app/controllers/courses_controller.rb,
./app/controllers/favorites_controller.rb
./app/controllers/friendships_controller.rb
./app/controllers/susbcriptions_controller.rb
./app/controllers/tokens_controller.rb
./app/controllers/tokens_controller.rb

## Author

👤 **Javier Botero**

- Github: [@Javierbotero](https://github.com/javierbotero)
- Twitter: [@Javierbotero1](https://twitter.com/JavierBotero1)
- Linkedin: [Javier Botero](https://www.linkedin.com/in/javierboterodev/)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

## Show your support

Give a ⭐️ if you like this project!
