class CreateAdmins < ActiveRecord::Migration[5.1]
  def change
    create_table :admins, id: false do |t|
      t.primary_key :login, :string, limit: 50, null: false
      t.string :password_digest, limit: 255, null: false
      t.string :remember_token, limit: 50

      t.timestamps
    end
  end
end
