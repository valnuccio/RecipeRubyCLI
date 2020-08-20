# == Schema Information
#
# Table name: recipes
#
#  id              :integer          not null, primary key
#  title           :string
#  minutes_to_make :integer
#  servings        :integer
#  directions      :string
#  photo_url       :string
#  nutrition_facts :string
#  price           :float
#
class Recipe < ActiveRecord::Base
    self.primary_key = :spoonacular_id
    serialize :directions, Array
    has_many :ingredient_recipes
    has_many :ingredients, through: :ingredient_recipes
    has_many :user_recipes
    has_many :users, through: :user_recipes





end
