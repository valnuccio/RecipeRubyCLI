class CreateRecipesTable < ActiveRecord::Migration[6.0]
  def change
  create_table :recipes do |t|
    t.string :title
    t.integer :minutes_to_make
    t.integer :servings
    t.string :directions
    t.string :photo_url
    t.string :nutrition_facts
    t.float :price
    end
  end
end
