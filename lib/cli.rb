require 'pry'


class CLI
    def start
        puts "Welcome to Recipe Ruby!"
        puts "Enter 1 if you would like to login"
        puts "Enter 2 if you would like to sign up"
        print ">> " 
        input=gets.chomp.to_i
        if input == 1
            login 
            #call on login method
        elsif input == 2
            #call on sign up method
        else 
            puts "That is an invalid choice! Try again"
        end
    end

    def login
        puts "What is your username?"
        print ">> "
        username = gets.chomp
        logged_in_user = User.find_by(username: username)
        if logged_in_user
            puts "Please enter your password"
            print ">> "
            password = gets.chomp
            if logged_in_user.password == password
                ## return USER LOGGED IN
            end
        else
        # if #username exists then request password.
        # else
        #     puts "Invalid username. Try again"
        end


    
    end



end

pen=CLI.new
pen.start


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