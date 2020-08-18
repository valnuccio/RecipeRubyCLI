




class CLI

    attr_accessor :current_user
    
    def self.start
        self.greeting
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
            menu.choice "Search for new recipes", -> { API.read_recipe(API.search) }
            menu.choice "Search for recipes by ingredients", -> { API.read_recipe(API.search_ingredient)}
            menu.choice "Check out our pantry", -> {  }
            menu.choice "View Recipe Book", -> {  }
            menu.choice "Random Recipe Generator", -> {  }
            menu.choice "Random Food Joke", -> {  }
            menu.choice "Exit", -> { exit }
        end
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