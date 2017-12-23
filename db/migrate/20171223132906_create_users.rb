class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.boolean :is_enabled
      t.boolean :is_admin
      t.timestamps
    end
  end
end
