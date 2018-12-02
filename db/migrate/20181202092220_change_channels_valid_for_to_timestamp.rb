class ChangeChannelsValidForToTimestamp < ActiveRecord::Migration[5.2]
  def change
    change_table :channels do | t |
      t.change :valid_for, :timestamp
    end
  end
end
