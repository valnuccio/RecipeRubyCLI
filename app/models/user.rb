# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  username   :string
#  password   :string
#  name       :string
#  location   :string
#  logged_in  :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ActiveRecord::Base
    has_many :user_ingredients
    has_many :user_recipes
    has_many :ingredients, through: :user_ingredients
    has_many :recipes, through: :user_recipes


    def self.login
        username = PROMPT.ask("Enter your Username >> ")
        logged_in_user = User.find_by(username: username)
        if logged_in_user
            entered_password = PROMPT.mask("Please enter your password >> ")
            fails = 0
            while entered_password != logged_in_user.password
                puts "Your passwords did not match".red.bold
                puts "Please try again".blue
                entered_password = PROMPT.mask("Please enter your password >> ")
                fails +=1
                if fails == 3
                    puts "Please make an account, or contact customer support for help resetting your password"
                    return false
                end
            end
        else
            puts "#{username} not found"
            return false
        end
        return logged_in_user
    end

    def self.signup
            
        PROMPT.collect do
            key(:username).ask("Username >> ")

            first_try = key(:password).mask("Password >> ")
            second_try = PROMPT.mask("Re-enter password >> ")
            while first_try != second_try
                puts "Your passwords did not match".red.bold
                puts "Please try again".blue
                first_try = key(:password).mask("Password >> ")
                second_try = PROMPT.mask("Re-enter password >> ")
            end
            key(:name).ask("Name >> ")
            key(:location).ask("Location >> ")
        end
    end

    def self.pantry
        if CLI.current_user.user_ingredients.length == 0
            if PROMPT.yes?("Would you like to create a pantry?")
                UserIngredient.create_pantry
            else
                return CLI.welcome_nav_bar
            end
        else
            UserIngredient.pantry_menu
        end
    end

    
end
