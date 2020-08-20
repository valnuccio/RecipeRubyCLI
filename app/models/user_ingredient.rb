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

    def self.create_pantry
        system ("clear")
        # a = Artii::Base.new :font => 'slant'
        # a.asciify("Let's make some food choices").red.bold
        choices = PROMPT.multi_select("Pantry Item(s):", per_page: 15) do |menu|
            menu.choice :onions,  -> { UserIngredient.find_or_create_by(user_id: CLI.current_user.id, ingredient_id: 11282) }
            menu.choice :rice,-> { UserIngredient.find_or_create_by(user_id: CLI.current_user.id, ingredient_id: 20444) }
            menu.choice :salt,    {score: 30}
            menu.choice :flour, -> {UserIngredient.find_or_create_by(user_id: CLI.current_user.id, ingredient_id: 20081) }
            menu.choice :milk, -> { UserIngredient.find_or_create_by(user_id: CLI.current_user.id, ingredient_id: 1077) }
            menu.choice :eggs, -> { UserIngredient.find_or_create_by(user_id: CLI.current_user.id, ingredient_id: 1123) }
            menu.choice :butter, -> { UserIngredient.find_or_create_by(user_id: CLI.current_user.id, ingredient_id: 1001) }
            menu.choice :sugar, -> { UserIngredient.find_or_create_by(user_id: CLI.current_user.id, ingredient_id: 19335) }
            menu.choice :pasta, -> {UserIngredient.find_or_create_by(user_id: CLI.current_user.id, ingredient_id: 11420420) }
        end
    
    end
end
        
    






