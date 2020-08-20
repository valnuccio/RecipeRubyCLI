# == Schema Information
#
# Table name: ingredients
#
#  id   :integer          not null, primary key
#  name :string
#
class Ingredient < ActiveRecord::Base
    self.primary_key = :spoonacular_ingredient_id
    has_many :user_ingredients
    has_many :ingredient_recipes
    has_many :recipes, through: :ingredient_recipes
    has_many :users, through: :user_ingredients

#flour
#salt
#black pepper
#rice
#pasta
#tomato sauce
#
 


end
