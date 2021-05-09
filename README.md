# Plant-Clinique

[Link to Plant-Clinique Staging App](http://plant-clinique-test.herokuapp.com/)

[Link to Plant-Clinique App](http://plant-clinique.herokuapp.com/)

[Link to Plant-Clinique API Repo](https://github.com/Plant-Clinique/Plant-Clinique-API/)

[Link to Final Report](https://plant-clinique.github.io/Plant-Clinique-Docs/)

# Introduction
Our application, Plant-Clinique, is a web-based application with the main goal of plant health. Essentially, it is a health checkup and care app for your plants. It will be able to remind you to water your plants as the Planta app does, but, in addition, it also has a chat functionality very similar to the Ada app where you can describe different conditions of your plant (leaf color, soil texture, how the blossoms look, how much fun it's getting), and the app will give you suggestions for how to improve the plant's health (recommend products or just actions you can take to improve your plant's condition). Users will also be able to post questions to a forum with tags (to group them) and those posts will have replies. Many people have let way too many plants die just because they didn't know what to do to keep them alive and didn't have anyone to ask, this app will solve that problem. 

# URL patterns

- Homepage: `/`
  - redirects to ~> GET `/users/:id` if signed in
  - redirects to ~> GET `/sign_in` if signed out
- Account
  - Sign in: GET `/sign_in`
  - Forgot password: 
    - GET `/passwords/new`
    - POST `/passwords`
  - Sign up: GET `/sign_up`
  - Create new user:
    - POST `/users`
    - POST `/passwords`
  - Sign out: DELETE `/sign_out`
- User management
  - User page: GET `/users/:id`
  - Edit user info: 
      - GET `/users/:id/edit` 
      - PATCH PUT `/users/:id`
  - Edit password: 
      - GET `/users/:user_id/password/edit`
      - PATCH PUT `/users/:user_id/password`
  - Delete user info: DELETE `/users/:id`
- User Plant
  - All plants: GET `/users/:id`
  - Add plant: 
    - GET `/user_plants/new`
    - POST `/user_plants`
  - Edit plant info: 
    - GET `/user_plants/:id/edit`
    - PATCH PUT `/user_plants/:id`
  - Delete plant: (in user page) DELETE `/user_plants/:id`
- Post
  - All posts: GET `/posts`
  - Edit post: 
    - GET `/posts/:id/edit`
    - PATCH PUT `/posts/:id`
  - Delete post: DELETE `/posts/:id`
  - Get posts of a specific topic: GET `/posts/search={topic_enum}&commit={topic}`
  - Read a post: GET `/posts/:id`
  - Add a new post:
    - GET `/posts/new`
    - POST `/posts/`
  - Add a reply: POST `/posts/:post_id/replies`
  - View replies (on a post): GET `/posts/:post_id/replies`
- Chatbot:
  - Visit the chatbot: GET `/chatbot_messages`
  - Send a message to the chatbot: POST `/chatbot_messages`
- Reminder (work in progress)

## Constraints

- SignedIn: GET `/` ~> "users#current_user_dashboard"
- SignedOut: GET `/` ~> `/sign_in` to "clearance/session#new"

# DB Schema

(🌱: primary key; <ins>underlined</ins>: foreign key)

## Schema

- <strong>User</strong>
  - user_id: integer 🌱
  - username: string
  - email: string
  - encrypted_password: string
  - confirmation_token: string
  - remember_token: string
  - admin: boolean
- <strong>UserPlant</strong>
  - plant_id: integer 🌱
  - <ins>user_id: integer</ins>
  - name: string
  - age: float
  - plant_type: string
  - image_url: string
  - description: string
- <strong>Reminder</strong>
  - reminder_id: integer 🌱
  - <ins>user_plant_id: integer</ins>
  - <ins>user_id: integer</ins>
  - tick_time: time
  - description: string
  - reminder_type: enum
- <strong>ChatbotMessage</strong>
  - chatbot_message_id: integer 🌱
  - <ins>user_id: integer</ins>
  - time_sent: datetime
  - from_bot: boolean
  - content: string
- <strong>Post</strong>
  - post_id: integer 🌱
  - <ins>user_id: integer</ins>
  - topic: enum
  - title: string
  - body: string
- <strong>Reply</strong>
  - reply_id: integer 🌱
  - <ins>user_id: integer</ins>
  - <ins>post_id: integer</ins>
  - body: string
- <strong>PlantType</strong>
  - plant_type_id: integer 🌱
  - name: string

## DB Associations

<img src="./images-readme/DB_associations.png" title="DB Associations" width="60%">

# App views

- <strong>Login/Sign Up/Logout</strong>: The Login is basic with a place for your email and password. The sign up has a space for your username, email, and password. The Logout takes you back to the log in page. These pages were customized to have a simple design that includes our logo.

<img src="./images-readme/Screen Shot 2021-05-08 at 2.39.05 PM.png" title="login" width="50%">
<img src="./images-readme/Screen Shot 2021-05-08 at 2.39.18 PM.png" title="signup" width="50%">
<img src="./images-readme/Screen Shot 2021-05-08 at 2.48.34 PM.png" title="forgot password" width="50%">


- <strong>My Account</strong>: This page will welcome you to the app, show you any plant related notifications you have, and more. If you have a question you can easily access the public forum, edit your own account info, and add a plant to your "garden". Your garden will be a collection of the plants you own, visually indicated below your user information. These plant cards can be edited, removed, and play a role in the chatbot feature.

<img src="./images-readme/Screen Shot 2021-05-08 at 2.49.18 PM.png" title="account page" width="50%">
<img src="./images-readme/Screen Shot 2021-05-08 at 2.49.31 PM.png" title="plant view" width="50%">
<img src="./images-readme/Screen Shot 2021-05-08 at 3.01.32 PM.png" title="plant view" width="50%">




- <strong>Chatbot</strong>: The chatbot uses a multiple choice questionnaire to ascertain information for the user. The chatbot is displayed on a single page that resembles Facebook messenger, where incoming messages from the bot are on the left. After the bot responds to the user it displays optional replies using bootsrap buttons. There is also a plus sign on all pages (when logged in) in the bottom right corner for an instant jump to the chatbot.

<img src="./images-readme/Screen Shot 2021-05-08 at 2.50.35 PM.png" title="chatbot" width="50%">
<img src="./images-readme/Screen Shot 2021-05-08 at 2.50.41 PM.png" title="chatbot" width="50%">
<img src="./images-readme/Screen Shot 2021-05-08 at 2.50.52 PM.png" title="chatbot" width="50%">


- <strong>Forum Posts</strong>: This page is robust because posts can be filed by a different enum topic, and because a post can have many replies. The URL patterns above demonstrate the many functionalities, but this is our basic forum. Currently we have used data from the Faker gem to populate posts (Faker::Movies::Ghostbusters.quote). Posts and comments you submit are editable.


<img src="./images-readme/Screen Shot 2021-05-08 at 2.50.19 PM.png" title="posts" width="50%">
<img src="./images-readme/Screen Shot 2021-05-08 at 2.50.02 PM.png" title="new post" width="50%">
<img src="./images-readme/Screen Shot 2021-05-08 at 2.50.29 PM.png" title="new post" width="50%">


- application.html.erb (header, footer, scrollbar): This is the code where we implemented the navbar, the footer, and the scroll bar. The scroll bar was implemented using CSS. The footer was implemented using bootsrap and includes links to helpful areas. The bootsrap navbar helps the user with accessibility and has links to all the pages of our app, including the login and logout.

- Reminders: This allows users to put in and store reminders for their plants. There is also be a clock on right with a calendar date so that the user knows what time they are putting into their reminder. 

<img src="./images-readme/Screen Shot 2021-05-08 at 2.51.06 PM.png" title="reminders" width="50%">


- Notifications: This allows the user to check on posts that have been interacted with, with an option to clear them all out at any point 

<img src="./images-readme/Screen Shot 2021-05-08 at 4.52.45 PM.png" title="notifications" width="50%">


- Maps: This page shows you a local view of the area around you and you can search for local plant stores.

<img src="./images-readme/Screen Shot 2021-05-08 at 2.50.59 PM.png" title="maps" width="50%">


# Original Paper Prototypes

<img src="./images-readme/Proto2.jpg" title="DB Associations" width="100%">

<img src="./images-readme/Proto1.jpg" title="DB Associations" width="100%">

# Testing
To run the unit test for models, do

`rails test:models`


To run integration tests for Clearance and RailsAdmin, do

`rails spec`


# Dependencies (APIs, Gem, Libraries)

(🌟: particularly interesting)

## APIs

- [Trefle](https://trefle.io/) 🌟: Currently used in the [chatbot](https://github.com/Plant-Clinique/Plant-Clinique/blob/9871876d25563ac6196ea39ce81cd14a7a9c5777/app/helpers/chatbot_messages_helper.rb#L13-L14) to get information about plants based on plant type, including sunlight, water, temperature, and many more. It has an exhaustive list of plants sourced from USDA, Wikimedia, and more. 
- [OpenWeather](https://openweathermap.org/api): Planning to use this for fetching weather at the current user's location so that we can estimate temperatures and better understand what plants the user can grow at home.
- [Ambee Soil](https://www.getambee.com/api/soil): Planning to use this for fetching soil information to better estimate what plants the user can grow at home.

## Gems
- [Clearance](https://github.com/thoughtbot/clearance) 🌟: Currently used for authenticating/authorizing users and things like remembering them and validating their login/signup data. We're working on finalizing the forgot-password feature using this gem, as well. 
- [binding_of_caller](https://github.com/banister/binding_of_caller): Currently used in development to aid in debugging. It allows us to evaluate code to check the state of our objects whenever we hit an error directly in the browser.
- [RailsAdmin](https://github.com/sferik/rails_admin): Currently used in development, test, QA, and production. To make a new RailsAdmin you have to create it in the console like (below). To use it, sign in with admin user and go to `/admin`
  ```
  ~ rails c
  > new_admin = User.where(username: "osamah").first
  => #<User id: 37, username: "osamah", created_at: "2021-04-03 20:58:02.7221...
  > new_admin.admin = true
  => true
  > new_admin.save
  => true
  ```
- [rubocop](https://github.com/rubocop/rubocop): Currently used for our backend team to check code style. We also have it set up in a GitHub workflow action ([check here](https://github.com/Plant-Clinique/Plant-Clinique/blob/473db669e95584defb644bd3e156ca7bab2a36cc/.github/workflows/rails.yml#L50)) to easily see what the linter thinks about the code in the pull request (e.g. [see how it evaluated for this PR](https://github.com/Plant-Clinique/Plant-Clinique/runs/2108178436?check_suite_focus=true)).
- [Kaminari](https://github.com/kaminari/kaminari) 🌟: Currently used for paginating the posts page every 7 posts. We didn't like how we had to scroll way down to see all posts because then we would have to scroll all the way back to get to the topics pills; this solved the problem.
- [RSpec](https://github.com/rspec/rspec-rails) 🌟: Currently used for [integration tests](https://github.com/Plant-Clinique/Plant-Clinique/tree/main/spec/features), which as you can see in that link we've done for Clearance (signing in, signing up, and signing out), and RailsAdmin (visitor is admin, visitor is not admin).
- [rails-controller-testing](https://github.com/rails/rails-controller-testing): Currently used in our in progress [user plants integration tests](https://github.com/Plant-Clinique/Plant-Clinique/blob/main/spec/requests/user_plants_spec.rb#L46) to check that the correct template is getting rendered on GET request to edit a user's plant.
- [factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails): Currently used in our [integration tests](https://github.com/Plant-Clinique/Plant-Clinique/tree/main/spec/features) to generate users for Clearance and RailsAdmin integration testing (similar to what Rails' native fixtures do).
- [active_record-events](https://github.com/pienkowb/active_record-events) 🌟: Currently used for adding an editted tag to posts that have been edited. It also allows us to keep track of the exact time a post was edited. We plan to use this for replies as well.
- [Wicked](https://github.com/zombocom/wicked): Planning to use this in the chatbot so that it can ask more types of questions without bloating the code. This is currently in progress ([here is the PR](https://github.com/Plant-Clinique/Plant-Clinique/pull/44)).
- [Select2](https://github.com/argerim/select2-rails): Planning to use this to integrate jQuery Select2 plugin that allows users to search in a selectbox. This would be very useful for searching plant types when making or updating a user plant. 
- [Noticed](https://github.com/excid3/noticed): Planning to integrate this with our Twilio powered reminders that are currently in progress as well.

## More
- [Heroku Scheduler](https://devcenter.heroku.com/articles/scheduler): Planning to use this to help us with sending reminders to users. 
- [Twilio](https://www.twilio.com/blog/2017/12/send-sms-ruby-rails-5-coffee.html): Planning to use this to send the reminders to users through sms.

# Stage 4 Deliverables 

## Prabu:
- Gravatars
- UI Fixups: buttons, error pages, responsiveness, chatbot ui

## Eric:
- UI updates: 
  - Upgrading post top have a sorting button, adding responsiveness 
  - Creating the reminders, Maps, and the notifications UI
  - Script work in navbar, account page, and reminders
  - Updating the login and sign up buttons 
  - Creating the chatbot steps UI 
  - Added responsiveness and collapsibility in navbar 

## Osamah:
- Chatbot v2.0: uses Wicked gem to create unique step by step chatbot conversations where users must answer questions about their plants’ condition, and the chatbot will estimate possible treatments using the Trefle API and this [Penn State University study](https://extension.psu.edu/preventing-diagnosing-and-correcting-common-houseplant-problems) that I translated into this [json file](https://github.com/Plant-Clinique/Plant-Clinique/blob/main/lib/assets/symptoms.json) ([demo video](https://drive.google.com/file/d/1bjiX44d5YHKiJzlv_T8YpAqp5OnaoLRW/view)).
- Store Locator: a searchable Mapbox map with user location access and stores where users can buy plants ([demo video](https://drive.google.com/file/d/1MPTDjMQ-K9o4QrbaCHNZxzw7idhPqC0d/preview)).
- Plant type searchable select box using Select2 jQuery plugin and Trefle API data.
- Plant image generated for new plants automatically using Pixabay API.
- Users now get notifications when someone replies to their posts using the “notifications” gem.

## Roman:
- User page backend
- Fixed a few routing bugs
  - Disabled some unsafe routes
- Create front-backend connections to create reminders
- Automatically send email as reminders to users using Heroku Scheduler

## <strong>Going Forward for the final deliverable: </strong>

## Prabu:
- Working on reminders UI using Wicked gem
  - Fetched water information using trefle api
  - Working on implementation of backend code with Wicked frontend implementation
- Working on building a machine learning model for “Help user pick a plant” feature
  - Finished data retrieval from trefle api
  - Working on model design and implementation
  - Working on model integration with app

## Eric:
- UI clean ups / updates / etc 
- Interesting script to make the pages more engaging/responsible 
- https://www.maissan.net/articles/simulating-vines attempt something like this 

## Osamah:
- General bug fixes
- Clean up smelly backend code in views
- Add sorting for posts and reminders
- Add like/dislike button
- Bonus: add something that helps users choose plants

## Roman:
- Showing the right time zones for users
- Make sure users can’t access “/users” or other user’s data
- Work with Prabu on the ML model
