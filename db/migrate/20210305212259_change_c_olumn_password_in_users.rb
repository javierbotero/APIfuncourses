class ChangeCOlumnPasswordInUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :password, :password_digest
    add_column :users, :password_confirmation, :string
  end
end
