class AddSpoonacularIngredientIdToIngredientsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :ingredients, :spoonacular_ingredient_id, :integer
  end
end
