class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :name
      t.string :screenName
      t.string :position
      t.string :imagePath
      t.string :state

      t.timestamps
    end
  end
end
