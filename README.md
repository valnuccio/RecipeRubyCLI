# Welcome to Recipe Ruby

## What is this app?

This is a command line app to search for recipes.  It is heavily based on the Spoonacular API.  They are really good folks, and highly recommend checking out what they're doing.

You can search for recipes by title or ingredient, get a random recipe.  Look at previously made recipes and rate them personally.

### What Makes this unique?

We have added a pantry function that you can add things you have on hand and search recipes by those items.  

--- 
### How Do I Begin? Installation
- First you will have to bundle install
    - One error that may pop up is due to Catpix. Let's walk through this.  
        - Catpix depends on rmagick that has a core dependency called imagemagic
        - Due to it being an old gem we have to install a specific imagemagick file, if you have brew installed do the following:
             1. brew install imagemagick@6 
             2. brew link --force imagemagick@6

        * To install brew on a mac https://treehouse.github.io/installation-guides/mac/homebrew
    
    - If installation goes well you should be all set

---

## Running
- In the folder you can run `ruby run.rb`
- Brings you to login screen, first time through you can sign up.  Menu options you will see at first
    - Search
    - Search by Ingredient
    - Pantry
    - Recipe Book
    - Random recipe
    - Random food joke

---

### Search
Put in something you would like to have