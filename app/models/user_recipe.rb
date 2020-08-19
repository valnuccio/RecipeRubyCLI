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
        current_recipe_save = UserRecipe.find_or_create_by(user_id: CLI.current_user.id, recipe_id: recipe.spoonacular_id)
        if made?
            star_review=PROMPT.slider("Rating", max: 5, step: 1, symbols: {bullet: "✭"})
            written_review=PROMPT.ask("Tell us what you thought!")
            current_recipe_save.increment!(:times_made, by = 1)
            current_recipe_save.update(star_rating: star_review, review: written_review, last_time_made: Date.today)
        end
        CLI.welcome_nav_bar
    end
       
    def self.made?
        PROMPT.select("Did you make it?") do |menu|
            menu.choice "Made it!", true
            menu.choice "Just browsing", false
          end
    end
end
