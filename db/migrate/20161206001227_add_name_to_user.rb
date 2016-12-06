class AddNameToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :name, :string
    add_column :users, :avatar, :string
    add_column :users, :bio, :string
    add_column :users, :location, :string
    add_column :users, :joined, :string
  end
end
