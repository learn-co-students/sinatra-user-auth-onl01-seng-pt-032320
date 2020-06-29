class Users < ActiveRecord::Migration
  def change
    create_table :users 
    t.string :name
    t.string :email
    t.string :password
  end 
  end
end
