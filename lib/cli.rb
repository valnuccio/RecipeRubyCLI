




class CLI

    attr_accessor :current_user
    
    def self.start
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
        directions = recipe['analyzedInstructions'][0]['steps']
        
        # Image.new(photo_url)
        puts title.red  #ASCII HERE
        puts summary.green
        puts
        puts "Ready in " + "#{time}".red
        puts "Servings " + "#{servings}".red
        puts
        ###INGREDIENTS 
        recipe["extendedIngredients"].each do |ele| 
            #### ADD INGREDIENT SPOONACULAR ID
            #### current_ingredient = Ingredient.find_or_create_by(spoonacular_id: ele["id"], name: SOMETHING )
            #### IngredientRecipe.find_or_create_by(ingredient_id: current_ingredient.id, recipe_id: current_recipe.id)
            puts ele["originalString"].light_cyan

        end

        ## Add Summary? TO RECIPES TABLE
        ### EASY WAY
        # attempt["instructions"]

        ### LETS MAKE THIS DIFFICULT
        
        ### Recipe.update(directions: steps)
        directions.each do |step|
            puts "Step #{step['number']}.".blue
            puts "     #{step['step']}".yellow
        end
        ### NUTRITION FACTS API CALL
        ###PRICE BREAKDOWN (url = URI("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/1003464/priceBreakdownWidget.json"))
        nil

        #### SAVE RECIPE ?!?!?!?!!? UPDATE RECIPE INFO AS WE GO

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