class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :name
      t.string :screenName
      t.string :position
      t.string :imagePath
      t.string :state
      t.integer :duration, :default => 0 # minutes
      t.timestamp :time_available

      t.timestamps
    end
  end
end
