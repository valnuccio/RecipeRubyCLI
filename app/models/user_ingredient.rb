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

end
