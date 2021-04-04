# Plant-Clinique - Introduction
Repo for us to make and track Plant Clinique features

# URL patterns
* Clearance/Password: New, Create
* Clearance/Session: Create, New, Destroy
* User: Create
    * Password: Create, Edit, Update
    New, Show, Create, Edit, Update, Destroy (no Index)
* Post: Index, New, Show, Create, Edit, Update, Destroy (all)
    * Reply: Index, Create
* Chatbot_message: Index, New, Show, Create
* User_plant: New, Show, Create, Edit, Update, Destroy (no Index)
* Reminder: Index, New, Show, Create, Edit, Update, Destroy (all)

### Constraints
* SignedIn:     get root to "users#current_user_dashboard"
* SignedOut:    get root to "/sign_in" to clearance/session#new


# DB Schema

# App views

# Dependencies (APIs, Gem, Libraries)