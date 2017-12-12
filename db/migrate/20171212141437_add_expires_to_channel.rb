class AddExpiresToChannel < ActiveRecord::Migration[5.1]
  def change
    change_table :channels do | t |
      t.boolean :expires
    end
  end
end
