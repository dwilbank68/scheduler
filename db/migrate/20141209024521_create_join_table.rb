class CreateJoinTable < ActiveRecord::Migration
  def change
    create_table :unit_users do |t|
      t.integer :unit_id
      t.integer :user_id
      t.timestamp :start_time
      t.integer :duration_hrs, :default => 0
      t.integer :duration_min, :default => 5
      t.text :note
    end
    add_index :unit_users, :unit_id
    add_index :unit_users, :user_id
  end
end
