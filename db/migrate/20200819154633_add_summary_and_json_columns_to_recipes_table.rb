class AddSummaryAndJsonColumnsToRecipesTable < ActiveRecord::Migration[6.0]
  def change
    add_column :recipes, :summary, :text
    add_column :recipes, :info_json, :json
  end
end
