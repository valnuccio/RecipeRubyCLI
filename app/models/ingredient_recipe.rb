# == Schema Information
#
# Table name: ingredient_recipes
#
#  id            :integer          not null, primary key
#  ingredient_id :integer
#  recipe_id     :integer
#
class IngredientRecipe < ActiveRecord::Base
belongs_to :ingredient
belongs_to :recipe

end
