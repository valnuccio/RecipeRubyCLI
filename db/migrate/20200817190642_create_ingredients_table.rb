class CreateIngredientsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :ingredients do |t|
      t.string :name
    end
  end
end
