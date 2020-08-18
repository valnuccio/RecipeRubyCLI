




class CLI

    attr_accessor :current_user
    
    def start
        greeting
        @current_user = opening_prompt
        welcome_nav_bar
        binding.pry
    end
    
    
    
    def opening_prompt
        current_user = false
        while !current_user
            current_user = PROMPT.select("What would you like to do?") do |menu|
                menu.choice "Login", -> { User.login }
                menu.choice "Signup", -> { User.create(User.signup) }
                menu.choice "Exit", -> { exit }
            end
        end
        current_user
    end

    def welcome_nav_bar
        #ascii for name
        #add fun food fact
        PROMPT.select("#{current_user.name}, what would you like to do?") do |menu|
            menu.choice "Search for new recipes", -> { search }
            menu.choice "Search for recipes by ingredients", -> { }
            menu.choice "Check out our pantry", -> {  }
            menu.choice "View Recipe Book", -> {  }
            menu.choice "Random Recipe Generator", -> {  }
            menu.choice "Random Food Joke", -> {  }
            menu.choice "Exit", -> { exit }
        end
    end

    def api_stuff(url)        
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Get.new(url)
        request["x-rapidapi-host"] = HOST
        request["x-rapidapi-key"] = KEY

        response = http.request(request)
        JSON.parse(response.read_body)
    end


    def search(recipe)
        
        url = URI("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/search?query=#{recipe}")

        found_recipes = api_stuff(url)
        binding.pry
         # returns 10 recipes
        # choices = [found_recipes["results"][:title] ]
        
            # found_recipes["results"] enters into the array
            # array keys/ answers include
            # spoonacular - id    ADD COLUMN
            # ready in minutes - integer (result may be nice to see)
            # servings - integer
            # source - url  ??? not sure what to do with that, added column to table?
            # image = image.... see if that is part of url
        
    end

def search_ingredient(ingredient)



end


    def greeting
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