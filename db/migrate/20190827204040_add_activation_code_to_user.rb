class AddActivationCodeToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :activation_code, :string
  end
end
