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


    

    def sign_up
        #passes info in
        # we have to make sure user doesnt exist
        #makes sure username isn't taken
        User.create
    end
end
