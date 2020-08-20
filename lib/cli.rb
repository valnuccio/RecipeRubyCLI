




class CLI

    attr_accessor :current_user
    
    def self.current_user
        @@current_user
    end

    def self.play_music
        pid = fork {exec 'afplay', "lib/GBBO.mp3"}
    end

    # pid = fork{ system 'killall', 'afplay' }
    
    def self.start
        system "clear"
        self.nav_bar_greeting
        @@current_user = self.opening_prompt
        self.welcome_nav_bar
        
    end
    
    
    
    def self.opening_prompt
        # exit_music=fork{ system 'killall', 'afplay' }
        @@current_user = false
        # self.play_music
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
        system ("clear")

        puts
        puts
        puts
        puts

        puts "
                 __...--~~~~~-._   _.-~~~~~--...__
              //               `V'               \\         ██████╗░███████╗░█████╗░██╗██████╗░███████╗  ██████╗░██╗░░░██╗██████╗░██╗░░░██╗
             //                 |                 \\        ██╔══██╗██╔════╝██╔══██╗██║██╔══██╗██╔════╝  ██╔══██╗██║░░░██║██╔══██╗╚██╗░██╔╝
            //__...--~~~~~~-._  |  _.-~~~~~~--...__\\       ██████╔╝█████╗░░██║░░╚═╝██║██████╔╝█████╗░░  ██████╔╝██║░░░██║██████╦╝░╚████╔╝░
            //__.....----~~~~._\ | /_.~~~~----.....__\\      ██╔══██╗██╔══╝░░██║░░██╗██║██╔═══╝░██╔══╝░░  ██╔══██╗██║░░░██║██╔══██╗░░╚██╔╝░░
          ====================\\|//====================     ██║░░██║███████╗╚█████╔╝██║██║░░░░░███████╗  ██║░░██║╚██████╔╝██████╦╝░░░██║░░░
                             `---`                         ╚═╝░░╚═╝╚══════╝░╚════╝░╚═╝╚═╝░░░░░╚══════╝  ╚═╝░░╚═╝░╚═════╝░╚═════╝░░░░╚═╝░░░®".red
        #add fun food fact
        puts
        puts
        puts
        puts
        puts
        PROMPT.select("#{@@current_user.name}, what would you like to do?", per_page: 7) do |menu|
            menu.choice "Search for new recipes", -> { read_recipe(API.search) }
            menu.choice "Search for recipes by ingredients", -> { read_recipe(API.search_ingredient)}
            menu.choice "Check out our pantry", -> { User.pantry  }
            menu.choice "View Recipe Book", -> {UserRecipe.view_recipe_book}
            menu.choice "Random Recipe Generator", -> {read_recipe(API.random_recipe)}
            menu.choice "Random Food Joke", -> { API.joke }
            menu.choice "Exit", -> { exit }
        end
    end




    def self.read_recipe(recipe)
        #(recipe passed in is the format received from JSON)
        ## MAYBE FIX WITH A BEGIN AND RESCUE!!!!!!
        #puts "
        
       
       
       
        
        
        begin
            title = recipe['title']
            time = recipe['readyInMinutes']
            servings = recipe['servings']
            summary = Nokogiri::HTML::Document.parse(recipe["summary"]).text
            photo_url = recipe['image']
            recipe_spoonacular_id = recipe['id']
            nutrition_facts = API.get_recipe_nutrition_facts(recipe_spoonacular_id)
            price = API.get_recipe_price(recipe_spoonacular_id)
            begin
                directions = recipe['analyzedInstructions'][0]['steps']
            rescue
                directions = [{'number'=> 1, 'step'=> "NO INSTRUCTIONS PROVIDED"}]
            end
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
            puts "Ingredient List: (" + "WHITE".white + " means we have it " + "LIGHT BLUE".light_cyan + " means you have grocery shopping to do)"
            puts
            needs = []
            recipe["extendedIngredients"].each do |ele| 
                    current_ingredient = Ingredient.find_or_create_by(spoonacular_ingredient_id: ele["id"])
                    current_ingredient.update(name: ele["name"])
                    IngredientRecipe.find_or_create_by(ingredient_id: ele["id"], recipe_id: current_recipe.spoonacular_id)
            
                    if UserIngredient.find_by(user_id: CLI.current_user.id, ingredient_id: ele["id"])
                        puts ele["originalString"].white
                    else
                        puts ele["originalString"].light_cyan
                        needs << ele["name"]
                    end
            end
            
            
            
            directions.each do |step|
                puts "Step #{step['number']}.".blue
                puts "     #{step['step']}".yellow
            end
            puts "You need to go buy: " + needs.join(", ").light_cyan.bold + "."
            puts
            puts
            PROMPT.select("What would you like to do next?") do |menu|
                menu.choice "Save this to My Recipe Book", -> {UserRecipe.save_and_rate(current_recipe)}#save it
                menu.choice "Return to Navigation Bar", -> {CLI.welcome_nav_bar} # nav bar
                menu.choice "Exit", -> { exit }
            end
        rescue
            puts "Something went wrong, returning to main menu".white.on_red
            sleep(2)
            return self.welcome_nav_bar
            ### SAVED RECIPE DIFFERENT FUNCTION?!?!?!?!
        end

    end

   
    # def self.view_recipe_book
    #     self.current_user.user_recipes.each do |ele|
    #         binding.pry 
    #     end

    # end


    # def self.greeting
    #     puts "
    #                             ░██╗░░░░░░░██╗███████╗██╗░░░░░░█████╗░░█████╗░███╗░░░███╗███████╗  ████████╗░█████╗░
    #                             ░██║░░██╗░░██║██╔════╝██║░░░░░██╔══██╗██╔══██╗████╗░████║██╔════╝  ╚══██╔══╝██╔══██╗
    #                             ░╚██╗████╗██╔╝█████╗░░██║░░░░░██║░░╚═╝██║░░██║██╔████╔██║█████╗░░  ░░░██║░░░██║░░██║
    #                             ░░████╔═████║░██╔══╝░░██║░░░░░██║░░██╗██║░░██║██║╚██╔╝██║██╔══╝░░  ░░░██║░░░██║░░██║
    #                             ░░╚██╔╝░╚██╔╝░███████╗███████╗╚█████╔╝╚█████╔╝██║░╚═╝░██║███████╗  ░░░██║░░░╚█████╔╝
    #                             ░░░╚═╝░░░╚═╝░░╚══════╝╚══════╝░╚════╝░░╚════╝░╚═╝░░░░░╚═╝╚══════╝  ░░░╚═╝░░░░╚════╝░

    #                                ██████╗░███████╗░█████╗░██╗██████╗░███████╗  ██████╗░██╗░░░██╗██████╗░██╗░░░██╗
    #                                ██╔══██╗██╔════╝██╔══██╗██║██╔══██╗██╔════╝  ██╔══██╗██║░░░██║██╔══██╗╚██╗░██╔╝
    #                                ██████╔╝█████╗░░██║░░╚═╝██║██████╔╝█████╗░░  ██████╔╝██║░░░██║██████╦╝░╚████╔╝░
    #                                ██╔══██╗██╔══╝░░██║░░██╗██║██╔═══╝░██╔══╝░░  ██╔══██╗██║░░░██║██╔══██╗░░╚██╔╝░░
    #                                ██║░░██║███████╗╚█████╔╝██║██║░░░░░███████╗  ██║░░██║╚██████╔╝██████╦╝░░░██║░░░
    #                                ╚═╝░░╚═╝╚══════╝░╚════╝░╚═╝╚═╝░░░░░╚══════╝  ╚═╝░░╚═╝░╚═════╝░╚═════╝░░░░╚═╝░░░®".red
    #     puts
    #     puts
    #     puts
    # end





def self.nav_bar_greeting

puts"                    ██████                                  
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
    ██▒▒▒▒████▒▒▒▒▒▒██                               ░██╗░░░░░░░██╗███████╗██╗░░░░░░█████╗░░█████╗░███╗░░░███╗███████╗  ████████╗░█████╗░
    ▓▓▒▒▒▒██▒▒▒▒▒▒██░░                               ░██║░░██╗░░██║██╔════╝██║░░░░░██╔══██╗██╔══██╗████╗░████║██╔════╝  ╚══██╔══╝██╔══██╗                                   
  ▓▓░░▒▒██▒▒▒▒▒▒██                                   ░╚██╗████╗██╔╝█████╗░░██║░░░░░██║░░╚═╝██║░░██║██╔████╔██║█████╗░░  ░░░██║░░░██║░░██║                                   
  ██▒▒██▒▒▒▒▒▒██                                     ░░████╔═████║░██╔══╝░░██║░░░░░██║░░██╗██║░░██║██║╚██╔╝██║██╔══╝░░  ░░░██║░░░██║░░██║                                   
██▒▒██▒▒▒▒▒▒██                                       ░░╚██╔╝░╚██╔╝░███████╗███████╗╚█████╔╝╚█████╔╝██║░╚═╝░██║███████╗  ░░░██║░░░╚█████╔╝                                   
██▓▓▒▒▒▒▒▒██                                         ░░░╚═╝░░░╚═╝░░╚══════╝╚══════╝░╚════╝░░╚════╝░╚═╝░░░░░╚═╝╚══════╝  ░░░╚═╝░░░░╚════╝░                                  
████▒▒▒▒▒▒██                                                      
██▒▒▒▒▒▒██                                                                              ██████╗░███████╗░█████╗░██╗██████╗░███████╗  ██████╗░██╗░░░██╗██████╗░██╗░░░██╗   
██▒▒▒▒▒▒██                                                                              ██╔══██╗██╔════╝██╔══██╗██║██╔══██╗██╔════╝  ██╔══██╗██║░░░██║██╔══██╗╚██╗░██╔╝  
██▒▒▒▒▒▒██                                                                              ██████╔╝█████╗░░██║░░╚═╝██║██████╔╝█████╗░░  ██████╔╝██║░░░██║██████╦╝░╚████╔╝░  
████▒▒▒▒▒▒████                                                                          ██╔══██╗██╔══╝░░██║░░██╗██║██╔═══╝░██╔══╝░░  ██╔══██╗██║░░░██║██╔══██╗░░╚██╔╝░░ 
██▒▒▒▒▒▒▒▒██▒▒██                                                                        ██║░░██║███████╗╚█████╔╝██║██║░░░░░███████╗  ██║░░██║╚██████╔╝██████╦╝░░░██║░░░ 
▒▒██▒▒▒▒▒▒▒▒▒▒████                                                                      ╚═╝░░╚═╝╚══════╝░╚════╝░╚═╝╚═╝░░░░░╚══════╝  ╚═╝░░╚═╝░╚═════╝░╚═════╝░░░░╚═╝░░░® 
▓▓▒▒▒▒▒▒▒▒▒▒▒▒██▒▒██                                                              
▓▓▒▒▒▒▒▒▒▒▒▒▒▒██▒▒▒▒██                                                              
██▒▒▒▒▒▒▒▒▒▒▒▒██▒▒▒▒██                                                                
██▒▒▒▒▒▒▒▒▒▒██▒▒▒▒▒▒██                                                                
██▒▒▒▒▒▒██▒▒▒▒▒▒▒▒██                                                                
██▒▒▒▒▒▒██▒▒▒▒▒▒██                                                                  
██████▒▒▒▒▒▒▒▒██                                                                  
██████████                                                                    
░░░░                                                                                     
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

