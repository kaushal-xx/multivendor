class AddAuthenticationTokenToSmeUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :sme_users, :authentication_token, :string, limit: 30
    add_index :sme_users, :authentication_token, unique: true
  end
end
