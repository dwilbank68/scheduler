class AddColumnsToUnitUsers < ActiveRecord::Migration
  def change
    add_column :unit_users, :start_time, :timestamp
    add_column :unit_users, :duration, :integer
    add_column :unit_users, :note, :text
  end
end
