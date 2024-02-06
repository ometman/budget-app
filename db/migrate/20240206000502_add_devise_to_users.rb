class AddDeviseToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :encrypted_password, :string, null: false, default: ""
  end
end
