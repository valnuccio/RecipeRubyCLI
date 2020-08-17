# == Schema Information
#
# Table name: ingredients
#
#  id   :integer          not null, primary key
#  name :string
#
class Ingredient < ActiveRecord::Base
has_many :user_ingredients
has_many :ingredient_recipes
 


end
