class CreateUserTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :user_tokens do |t|
      t.references :user, foreign_key: true
      t.string :provider
      t.string :token
      t.string :uid

      t.timestamps
    end
  end
end
