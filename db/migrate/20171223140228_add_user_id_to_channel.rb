class AddUserIdToChannel < ActiveRecord::Migration[5.1]
  def change
    change_table :channels do | t |
      t.integer :user_id
    end
  end
end
