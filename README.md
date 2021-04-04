# Plant-Clinique - Introduction
Repo for us to make and track Plant Clinique features

# URL patterns
* Clearance/Password: New, Create
* Clearance/Session: Create, New, Destroy
* User: Create
    * Password: Create, Edit, Update </br>
    New, Show, Create, Edit, Update, Destroy (no Index)
* Post: Index, New, Show, Create, Edit, Update, Destroy (all)
    * Reply: Index, Create
* Chatbot_message: Index, New, Show, Create
* User_plant: New, Show, Create, Edit, Update, Destroy (no Index)
* Reminder: Index, New, Show, Create, Edit, Update, Destroy (all)

## Constraints
* SignedIn:     get root to "users#current_user_dashboard"
* SignedOut:    get root to "/sign_in" to clearance/session#new


# DB Schema
(🌱: primary key; <u>underlined</u>: foreign key)
## Schema
* <strong>User</strong>
    * user_id: integer 🌱
    * username: string
    * email: string
    * encrypted_password: string 
    * confirmation_token: string
    * remember_token: string
    * admin: boolean 
* <strong>UserPlant</strong>
    * plant_id: integer 🌱
    * <u>user_id: integer</u>
    * name: string 
    * age: float 
    * plant_type: string 
    * image_url: string 
    * description: string 
* <strong>Reminder</strong>
    * reminder_id: integer 🌱
    * <u>user_plant_id: integer</u>
    * <u>user_id: integer</u>
    * reminder_time: datetime 
    * description: string 
    * reminder_type: enum
* <strong>ChatbotMessage</strong>
    * chatbot_message_id: integer 🌱
    * <u>user_id: integer</u>
    * time_sent: datetime 
    * from_bot: boolean 
    * content: string 
* <strong>Post</strong>
    * post_id: integer 🌱
    * <u>user_id: integer</u>
    * topic: enum 
    * title: string
    * body: string
* <strong>Reply</strong>
    * reply_id: integer 🌱
    * <u>user_id: integer</u>
    * <u>post_id: integer</u>
    * body: string
* <strong>PlantType</strong>
    * plant_type_id: integer 🌱
    * name: string
</br>
## DB Associations </br>
<img src="./images-readme/DB_associations.png" title="DB Associations" width="50%">


# App views

# Dependencies (APIs, Gem, Libraries)
## APIs
* [Trefle](https://trefle.io/): Currently used in the [chatbot](https://github.com/Plant-Clinique/Plant-Clinique/blob/9871876d25563ac6196ea39ce81cd14a7a9c5777/app/helpers/chatbot_messages_helper.rb#L13-L14) to get information about plants based on plant type, including sunlight, water, temperature, and many more. It has an exhaustive list of plants sourced from USDA, Wikimedia, and more. 
* [OpenWeather](https://openweathermap.org/api): Planning to use this for fetching weather at the current user's location so that we can estimate temperatures and better understand what plants the user can grow at home.
* [Ambee Soil](https://www.getambee.com/api/soil): Planning to use this for fetching soil information to better estimate what plants the user can grow at home.
## Gems
* [Clearance](https://github.com/thoughtbot/clearance): Currently used for authenticating/authorizing users and things like remembering them and validating their login/signup data. We're working on finalizing the forgot-password feature using this gem, as well. 
* [binding_of_caller](https://github.com/banister/binding_of_caller): Currently used in development to aid in debugging. It allows us to evaluate code to check the state of our objects whenever we hit an error directly in the browser.
* [rubocop](https://github.com/rubocop/rubocop): Currently used for our backend team to check code style. We also have it set up in a GitHub workflow action ([check here](https://github.com/Plant-Clinique/Plant-Clinique/blob/473db669e95584defb644bd3e156ca7bab2a36cc/.github/workflows/rails.yml#L50)) to easily see what the linter thinks about the code in the pull request (e.g. [see how it evaluated for this PR](https://github.com/Plant-Clinique/Plant-Clinique/runs/2108178436?check_suite_focus=true)).
* [Kaminari](https://github.com/kaminari/kaminari): Currently used for paginating the posts page every 7 posts. We didn't like how we had to scroll way down to see all posts because then we would have to scroll all the way back to get to the topics pills; this solved the problem.
* [active_record-events](https://github.com/pienkowb/active_record-events): Currently used for adding an editted tag to posts that have been edited. It also allows us to keep track of the exact time a post was edited. We plan to use this for replies as well.
* [Wicked](https://github.com/zombocom/wicked): Planning to use this in the chatbot so that it can ask more types of questions without bloating the code. This is currently in progress ([here is the PR](https://github.com/Plant-Clinique/Plant-Clinique/pull/44)).
* [Select2](https://github.com/argerim/select2-rails): Planning to use this to integrate jQuery Select2 plugin that allows users to search in a selectbox. This would be very useful for searching plant types when making or updating a user plant. 
* [Noticed](https://github.com/excid3/noticed): Planning to integrate this with our Twilio powered reminders that are currently in progress as well.
## More
* [Heroku Scheduler](https://devcenter.heroku.com/articles/scheduler): Planning to use this to help us with sending reminders to users. 
* [Twilio](https://www.twilio.com/blog/2017/12/send-sms-ruby-rails-5-coffee.html): Planning to use this to send the reminders to users through sms.