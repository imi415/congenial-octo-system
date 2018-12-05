class AddAllowOriginalToChannels < ActiveRecord::Migration[5.2]
  def change
    change_table :channels do | t |
      t.boolean :allow_original, default: false
    end
  end
end
