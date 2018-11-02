class AddIsEnabledToChannel < ActiveRecord::Migration[5.2]
  def change
    change_table :channels do | t |
      t.boolean :is_enabled, default: true
    end
  end
end
