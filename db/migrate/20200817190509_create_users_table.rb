class CreateUsersTable < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :name
      t.string :location
      t.boolean :logged_in
      t.timestamps 
    end
  end
end
