# == Schema Information
#
# Table name: user_recipes
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  recipe_id      :integer
#  times_made     :integer
#  review         :string
#  star_rating    :integer
#  last_time_made :datetime
#
class UserRecipe < ActiveRecord::Base
    belongs_to :user
    belongs_to :recipe


    def self.save_and_rate(recipe)
        binding.pry
        UserRecipe.find_or_create_by(user_id: CLI.current_user.id, recipe_id: recipe.spoonacular_id)
        PROMPT.slider("Rating", max: 5, step: 1, symbols: {bullet: "✭"})

    end

end
# ✰✭