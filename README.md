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
    
    - HIGHLY IMPORTANT!!!
        - You will need your own api host and key for it to function on your home computer.

            * Rapidapi.com has the sign up for the Spoonacular API and you will be able to get a free key for 150 searchs a day from them.  Once you obtain a HOST and KEY do the following
                1. In the config/ folder, create a file called keys.rb
                2. In config/keys.rb you will need to input the following:
                    * HOST = ____ (the blank is to be filled in what Rapid API gives you for the spoonacular host)
                    * KEY = ____ (your personal key specifc to Rapid API)

    - If installation goes well you should be all set

    Some of our heavily relied on gems here include
    
    - Catpix 
        - Prints those lovely photos for you
    - TTY
        - Multiple libraries from those folks, including TTY-prompt for our menus and TTY-table for organizing recipes
    - Artii
        - Ascii like it's the 80s
    - Colorize
        - Making that text pretty
    - Nokogiri
        - Some responses are in pure html so we clean it up with this.  
    

---

## Running

- HIGHLY recommend using a black background, full screen terminal.  Some text may not be legible otherwise.
- In the folder you can run `ruby run.rb`
- Brings you to login screen, first time through you can sign up.  Menu options you will see at first
    - Search
    - Search by Ingredient
    - Pantry
    - Recipe Book
    - Random recipe
    - Random food joke

---

### Search/Search by Ingredient

- Put in something you would like to have for dinner. ** Regular search is just by title, ingredients put as many as you would like.  
    * Returns top 10 results.  Choose one see what looks tasty.
- After selecting a recipe, you will see the print out, and it will highlight what you have and what you are missing.  Look at the shopping list at the bottom.
- You can then save or go back to browsing.
- We think you should make something to eat though.

### Pantry
- Defaults to empty so will ask you if you want to add stuff when you first sign up, to make this easier we give 21 most likely options (my apologies to vegetarians for having non vegetarian options in our top 21).  

- After this is done you can add singular items to your pantry.  Remove items from your pantry, or one of our favourites, search for recipes with multiple items from your pantry! Sometimes you want to get rid of things. 

- Or return to main menu

### Recipe Book

- Another function we are very proud of is our saved recipes.  

- Select a previously saved recipe

    - You can look at what you made, when you made it last and how many times you made it.  

    - Change your review.

    - Just check if you have any of the ingredients

### Random Recipe Generator

- Sometimes you don't know what you want to eat, so we have thrown it up to the fates.  See what a random number wants you to have, follows the same path as searching an ingredient, you will view and have the option to save or go back to the main menu.

### Random food joke

- Mostly puns. Just food for thought. 


#### ENJOY!