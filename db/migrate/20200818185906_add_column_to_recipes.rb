class AddColumnToRecipes < ActiveRecord::Migration[6.0]
  def change
    add_column :recipes, :spoonacular_id, :integer
  end
end
