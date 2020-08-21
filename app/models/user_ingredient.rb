# == Schema Information
#
# Table name: user_ingredients
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  ingredient_id :integer
#
class UserIngredient < ActiveRecord::Base
    belongs_to :ingredient
    belongs_to :user


    def self.pantry_menu
        PROMPT.select("Welcome to your pantry, what would you like to do?") do |menu|
            menu.choice "Add multiple items from top 21 most common ingredients to my pantry", -> {self.create_pantry}
            menu.choice "Add a SINGLE ingredient to my pantry", ->  {self.add_single_ingredient}
            menu.choice "Choose items from my pantry to search for a recipe", -> { self.multi_search}
            menu.choice "View my pantry", -> {self.view_pantry}
            menu.choice "Return to Main Menu", -> {CLI.welcome_nav_bar}
            menu.choice "Exit", -> {CLI.exit_and_kill_music}
        end
    end

    def self.multi_search
        CLI.current_user.reload
        pantry = CLI.current_user.ingredients.map(&:name)
        
        listed = PROMPT.multi_select("You have added the following item(s):", pantry, per_page: pantry.length)
        if listed.length == 0
            puts "Whoops, you didn't slect anything try again".white.on_red.bold
            return self.multi_search
        end
        CLI.read_recipe(API.pantry_search(listed.join(", ")))
       
    end


    def self.create_pantry
        system ("clear")
        
        # CLI.centered(" Let's  make  some  food  choices ", true)
        self.pantry_title
        listed = choices = PROMPT.multi_select("You have added the following item(s):", per_page: 21) do |menu|
            menu.choice "Onions", -> { UserIngredient.find_or_create_by(user_id: CLI.current_user.id, ingredient_id: 11282) }
            menu.choice "Rice",-> { UserIngredient.find_or_create_by(user_id: CLI.current_user.id, ingredient_id: 20444) }
            menu.choice "Salt", ->  { UserIngredient.find_or_create_by(user_id: CLI.current_user.id, ingredient_id: 2047)}
            menu.choice "Flour", -> {UserIngredient.find_or_create_by(user_id: CLI.current_user.id, ingredient_id: 20081) }
            menu.choice "Milk", -> { UserIngredient.find_or_create_by(user_id: CLI.current_user.id, ingredient_id: 1077) }
            menu.choice "Eggs", -> { UserIngredient.find_or_create_by(user_id: CLI.current_user.id, ingredient_id: 1123) }
            menu.choice "Butter", -> { UserIngredient.find_or_create_by(user_id: CLI.current_user.id, ingredient_id: 1001) }
            menu.choice "Sugar", -> { UserIngredient.find_or_create_by(user_id: CLI.current_user.id, ingredient_id: 19335) }
            menu.choice "Pasta", -> {UserIngredient.find_or_create_by(user_id: CLI.current_user.id, ingredient_id: 20420) }
            menu.choice "Tomatoes", -> { UserIngredient.find_or_create_by(user_id: CLI.current_user.id, ingredient_id: 11529) }
            menu.choice "Olive Oil", -> { UserIngredient.find_or_create_by(user_id: CLI.current_user.id, ingredient_id: 4053) }
            menu.choice "Baking Soda", -> {  UserIngredient.find_or_create_by(user_id: CLI.current_user.id, ingredient_id: 18372) }
            menu.choice "Baking Powder", -> { UserIngredient.find_or_create_by(user_id: CLI.current_user.id, ingredient_id: 18371) }
            menu.choice "Pepper", -> { UserIngredient.find_or_create_by(user_id: CLI.current_user.id, ingredient_id: 20444)}
            menu.choice "Garlic", -> { UserIngredient.find_or_create_by(user_id: CLI.current_user.id, ingredient_id: 11215)}
            menu.choice "Red Wine Vinegar", -> { UserIngredient.find_or_create_by(user_id: CLI.current_user.id, ingredient_id: 1022068 )}
            menu.choice "Chicken", -> { UserIngredient.find_or_create_by(user_id: CLI.current_user.id, ingredient_id: 5006)}
            menu.choice "Chicken Broth", -> { UserIngredient.find_or_create_by(user_id: CLI.current_user.id, ingredient_id: 6194)}
            menu.choice "Lentils", -> { UserIngredient.find_or_create_by(user_id: CLI.current_user.id, ingredient_id: 10316069)}
            menu.choice "Black Beans", -> { UserIngredient.find_or_create_by(user_id: CLI.current_user.id, ingredient_id: 16015)}
            menu.choice "Ground Beef", -> { UserIngredient.find_or_create_by(user_id: CLI.current_user.id, ingredient_id: 10023572)}
            menu.choice "Return To Pantry Meny", -> {self.pantry_menu}
        end
        #puts self.add_multiple(listed)
        sleep(1)
        self.pantry_menu
    end

    def self.add_multiple(listed)
        success = "You have added:"
        listed.each do |item|
            success+= " #{item.ingredient.name.capitalize.green},"
        end
        success = success[0...-1] + "."
        success
    end

    def self.view_pantry
        system ("clear")
        self.pantry_title
        puts "You have the following:"
        CLI.current_user.reload
        CLI.current_user.ingredients.each_with_index do |ingredient, i|
            puts "      #{(i+1).to_s.red}. #{ingredient.name.capitalize.green}"
        end
        puts
        puts
        self.pantry_menu
    end

    def self.add_single_ingredient
        to_add = PROMPT.ask("What would you like to add?")
        self.add_to_pantry(to_add)
        puts "Added ".green + name.upcase.red + " to your pantry!".green
        sleep(1)
        self.pantry_menu
    end

    def self.wait_add
        sleep(1)
        self.pantry_menu
    end

    def self.add_to_pantry(ingredient)
        search_result = API.find_ingredient(ingredient)[0]
        spoonacular_ingredient_id = search_result["id"]
        name = search_result["name"]
        current_ingredient = Ingredient.find_or_create_by(spoonacular_ingredient_id: spoonacular_ingredient_id)
        current_ingredient.update(name: name)
        UserIngredient.create(user_id: CLI.current_user.id, ingredient_id: spoonacular_ingredient_id)
        sleep(1)
        self.pantry_menu
    end

    def self.pantry_title
        title = "██████╗ ██╗   ██╗██████╗ ██╗   ██╗    ██████╗  █████╗ ███╗   ██╗████████╗██████╗ ██╗   ██╗
██╔══██╗██║   ██║██╔══██╗╚██╗ ██╔╝    ██╔══██╗██╔══██╗████╗  ██║╚══██╔══╝██╔══██╗╚██╗ ██╔╝
██████╔╝██║   ██║██████╔╝ ╚████╔╝     ██████╔╝███████║██╔██╗ ██║   ██║   ██████╔╝ ╚████╔╝ 
██╔══██╗██║   ██║██╔══██╗  ╚██╔╝      ██╔═══╝ ██╔══██║██║╚██╗██║   ██║   ██╔══██╗  ╚██╔╝  
██║  ██║╚██████╔╝██████╔╝   ██║       ██║     ██║  ██║██║ ╚████║   ██║   ██║  ██║   ██║   
╚═╝  ╚═╝ ╚═════╝ ╚═════╝    ╚═╝       ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝   ╚═╝  ╚═╝   ╚═╝   
                                                                                          ".red

        CLI.centered(title)

    end
end
        
    






