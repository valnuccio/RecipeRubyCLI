




class CLI

    attr_accessor :current_user
    
    def self.start
        system "clear"
        self.nav_bar_greeting
        @@current_user = self.opening_prompt
        self.welcome_nav_bar
        
    end
    
    
    
    def self.opening_prompt
        @@current_user = false
        while !@@current_user
            @@current_user = PROMPT.select("What would you like to do?") do |menu|
                menu.choice "Login", -> { User.login }
                menu.choice "Signup", -> { User.create(User.signup) }
                menu.choice "Exit", -> { exit }
            end
        end
        @@current_user
    end

    def self.welcome_nav_bar
        #ascii for name
        #add fun food fact
        PROMPT.select("#{@@current_user.name}, what would you like to do?") do |menu|
            menu.choice "Search for new recipes", -> { read_recipe(API.search) }
            menu.choice "Search for recipes by ingredients", -> { read_recipe(API.search_ingredient)}
            menu.choice "Check out our pantry", -> {  }
            menu.choice "View Recipe Book", -> {  }
            menu.choice "Random Recipe Generator", -> {  }
            menu.choice "Random Food Joke", -> {  }
            menu.choice "Exit", -> { exit }
        end
    end




    def self.read_recipe(recipe)
        #(recipe passed in is the format received from JSON)
        title = recipe['title']
        time = recipe['readyInMinutes']
        servings = recipe['servings']
        summary = Nokogiri::HTML::Document.parse(recipe["summary"]).text
        photo_url = recipe['image']
        recipe_spoonacular_id = recipe['id']
        nutrition_facts = API.get_recipe_nutrition_facts(recipe_spoonacular_id)
        price = API.get_recipe_price(recipe_spoonacular_id)
        directions = recipe['analyzedInstructions'][0]['steps']
        
        current_recipe = Recipe.find_or_create_by(spoonacular_id: recipe_spoonacular_id)
        
        current_recipe.update(title: title,
                        minutes_to_make: time,
                        servings: servings,
                        summary: summary,
                        photo_url: photo_url,
                        price: price,
                        directions: directions,
                        nutrition_facts: nutrition_facts,
                        info_json: recipe)
        

        Image.new(photo_url)
        puts title.red  #ASCII HERE
        puts summary.green
        puts
        puts "Ready in " + "#{time}".red
        puts "Servings " + "#{servings}".red
        puts "Price per Serving " + "#{price}".red
        puts
        puts "Nutrition Facts: #{nutrition_facts.red}"
        puts
       
        recipe["extendedIngredients"].each do |ele| 
                current_ingredient = Ingredient.find_or_create_by(spoonacular_ingredient_id: ele["id"], name: ele["name"])
                IngredientRecipe.find_or_create_by(ingredient_id: spoonacular_ingredient_id.id, recipe_id: current_recipe.spoonacular_id)
                puts ele["originalString"].light_cyan
        end
        
        binding.pry
        
        directions.each do |step|
            puts "Step #{step['number']}.".blue
            puts "     #{step['step']}".yellow
        end
        
        
        PROMPT.select("What would you like to do next?") do |menu|
            menu.choice "Save this to My Recipe Book", -> {puts "saved?"}#save it
            menu.choice "Return to Navigation Bar", -> {puts "banana bread" } # nav bar
            menu.choice "Exit", -> { exit }
        end

        
        ### SAVED RECIPE DIFFERENT FUNCTION?!?!?!?!

    end

   


    def self.greeting
        puts "
                                ░██╗░░░░░░░██╗███████╗██╗░░░░░░█████╗░░█████╗░███╗░░░███╗███████╗  ████████╗░█████╗░
                                ░██║░░██╗░░██║██╔════╝██║░░░░░██╔══██╗██╔══██╗████╗░████║██╔════╝  ╚══██╔══╝██╔══██╗
                                ░╚██╗████╗██╔╝█████╗░░██║░░░░░██║░░╚═╝██║░░██║██╔████╔██║█████╗░░  ░░░██║░░░██║░░██║
                                ░░████╔═████║░██╔══╝░░██║░░░░░██║░░██╗██║░░██║██║╚██╔╝██║██╔══╝░░  ░░░██║░░░██║░░██║
                                ░░╚██╔╝░╚██╔╝░███████╗███████╗╚█████╔╝╚█████╔╝██║░╚═╝░██║███████╗  ░░░██║░░░╚█████╔╝
                                ░░░╚═╝░░░╚═╝░░╚══════╝╚══════╝░╚════╝░░╚════╝░╚═╝░░░░░╚═╝╚══════╝  ░░░╚═╝░░░░╚════╝░

                                   ██████╗░███████╗░█████╗░██╗██████╗░███████╗  ██████╗░██╗░░░██╗██████╗░██╗░░░██╗
                                   ██╔══██╗██╔════╝██╔══██╗██║██╔══██╗██╔════╝  ██╔══██╗██║░░░██║██╔══██╗╚██╗░██╔╝
                                   ██████╔╝█████╗░░██║░░╚═╝██║██████╔╝█████╗░░  ██████╔╝██║░░░██║██████╦╝░╚████╔╝░
                                   ██╔══██╗██╔══╝░░██║░░██╗██║██╔═══╝░██╔══╝░░  ██╔══██╗██║░░░██║██╔══██╗░░╚██╔╝░░
                                   ██║░░██║███████╗╚█████╔╝██║██║░░░░░███████╗  ██║░░██║╚██████╔╝██████╦╝░░░██║░░░
                                   ╚═╝░░╚═╝╚══════╝░╚════╝░╚═╝╚═╝░░░░░╚══════╝  ╚═╝░░╚═╝░╚═════╝░╚═════╝░░░░╚═╝░░░®".red
        puts
        puts
        puts
    end





def self.nav_bar_greeting
#     print"
#     __...--~~~~~-._   _.-~~~~~--...__
#     //               `V'               \\ 
#    //                 |                 \\ 
#   //__...--~~~~~~-._  |  _.-~~~~~~--...__\\ 
#  //__.....----~~~~._\ | /_.~~~~----.....__\\
# ====================\\|//====================
#                     `---`                       "
puts"                      ██████                                  
                    ████░░▒▒░░██                                
                ████▒▒░░▒▒▒▒▒▒▒▒██                              
              ▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                            
            ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                            
            ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                          
          ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                          
          ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                          
        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██      ████                
        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██  ████▒▒██  ████          
        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒████▒▒▒▒██  ██▒▒██          
        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██░░▒▒▒▒██  ██░░▒▒██          
        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██▒▒▒▒▒▒██  ██▒▒▒▒██  ████      
        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░██░░▒▒▒▒██  ██▒▒▒▒██  ██▒▒██      
        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██▒▒▒▒▒▒██  ██▒▒▒▒██  ▓▓▒▒▒▒██      
        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██▒▒▒▒██  ██▒▒▒▒██  ██░░▒▒██        
          ██▒▒▒▒▒▒▒▒▒▒▒▒░░▓▓▒▒▒▒▒▒██▓▓▒▒▒▒██  ▓▓░░▒▒▒▒██        
          ██▒▒▒▒▒▒▒▒▒▒░░▓▓▓▓▒▒▒▒▒▒▒▒▒▒░░██  ██░░▒▒▒▒██          
          ██▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒██▓▓░░▒▒▒▒▒▒██          
          ██▒▒▒▒▒▒▒▒██  ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒██            
          ██▒▒▒▒▒▒██    ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██              
        ██▒▒▒▒▒▒██    ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒████                
        ██▒▒▒▒██      ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓██                    
        ██▒▒██      ██▒▒▒▒▒▒▒▒▒▒▒▒██████                        
      ▓▓▒▒▒▒██    ▓▓▒▒▒▒▒▒▒▒▓▓████    ░░                        
      ██▒▒██    ██▒▒▒▒▒▒████                                    
      ██▒▒██  ▓▓▒▒▒▒▒▒██░░                                      
    ██▒▒▒▒████▒▒▒▒▒▒██       ░██╗░░░░░░░██╗███████╗██╗░░░░░░█████╗░░█████╗░███╗░░░███╗███████╗  ████████╗░█████╗░
    ▓▓▒▒▒▒██▒▒▒▒▒▒██░░       ░██║░░██╗░░██║██╔════╝██║░░░░░██╔══██╗██╔══██╗████╗░████║██╔════╝  ╚══██╔══╝██╔══██╗                                   
  ▓▓░░▒▒██▒▒▒▒▒▒██           ░╚██╗████╗██╔╝█████╗░░██║░░░░░██║░░╚═╝██║░░██║██╔████╔██║█████╗░░  ░░░██║░░░██║░░██║                                   
  ██▒▒██▒▒▒▒▒▒██             ░░████╔═████║░██╔══╝░░██║░░░░░██║░░██╗██║░░██║██║╚██╔╝██║██╔══╝░░  ░░░██║░░░██║░░██║                                   
██▒▒██▒▒▒▒▒▒██               ░░╚██╔╝░╚██╔╝░███████╗███████╗╚█████╔╝╚█████╔╝██║░╚═╝░██║███████╗  ░░░██║░░░╚█████╔╝                                   
██▓▓▒▒▒▒▒▒██                 ░░░╚═╝░░░╚═╝░░╚══════╝╚══════╝░╚════╝░░╚════╝░╚═╝░░░░░╚═╝╚══════╝  ░░░╚═╝░░░░╚════╝░                                  
████▒▒▒▒▒▒██                                                      
██▒▒▒▒▒▒██                   ██████╗░███████╗░█████╗░██╗██████╗░███████╗  ██████╗░██╗░░░██╗██████╗░██╗░░░██╗                                     
██▒▒▒▒▒▒██                   ██╔══██╗██╔════╝██╔══██╗██║██╔══██╗██╔════╝  ██╔══██╗██║░░░██║██╔══██╗╚██╗░██╔╝                                       
██▒▒▒▒▒▒██                   ██████╔╝█████╗░░██║░░╚═╝██║██████╔╝█████╗░░  ██████╔╝██║░░░██║██████╦╝░╚████╔╝░                                         
████▒▒▒▒▒▒████               ██╔══██╗██╔══╝░░██║░░██╗██║██╔═══╝░██╔══╝░░  ██╔══██╗██║░░░██║██╔══██╗░░╚██╔╝░░                                             
██▒▒▒▒▒▒▒▒██▒▒██             ██║░░██║███████╗╚█████╔╝██║██║░░░░░███████╗  ██║░░██║╚██████╔╝██████╦╝░░░██║░░░                                               
▒▒██▒▒▒▒▒▒▒▒▒▒████           ╚═╝░░╚═╝╚══════╝░╚════╝░╚═╝╚═╝░░░░░╚══════╝  ╚═╝░░╚═╝░╚═════╝░╚═════╝░░░░╚═╝░░░®                                                   
▓▓▒▒▒▒▒▒▒▒▒▒▒▒██▒▒██                                                              
▓▓▒▒▒▒▒▒▒▒▒▒▒▒██▒▒▒▒██                                                              
██▒▒▒▒▒▒▒▒▒▒▒▒██▒▒▒▒██                                                                
██▒▒▒▒▒▒▒▒▒▒██▒▒▒▒▒▒██                                                                
██▒▒▒▒▒▒██▒▒▒▒▒▒▒▒██                                                                
██▒▒▒▒▒▒██▒▒▒▒▒▒██                                                                  
██████▒▒▒▒▒▒▒▒██                                                                  
██████████                                                                    
░░░░                                                        ░░                              
░░░░░░░░░░░░░░░░░░                                                                          
".red
end
end
# class CLI

#     def start
#         puts "Welcome to the Pet Adoption CLI!"
#         user = User.login 

#         # user.adopt_animal
#         # Animal.list_animals


#         # we should refactor this! it works now! 
#         puts "Which animal would you like to adopt?"
#         Animal.all.each do |animal|
#             puts animal[:name]
#         end
#         animal_name = gets.chomp
#         UserAnimal.create(user: user, animal: Animal.find_by(name: animal_name))
#         binding.pry 
#     end

    
# end