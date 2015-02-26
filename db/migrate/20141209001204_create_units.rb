class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :screen_name
      t.string :position
      t.string :image_path
      t.string :state
      t.integer :duration, :default => 0 # minutes
      t.string :unit_pic
      t.timestamp :time_available
      t.user_disabler :string
      t.when_disabled :datetime
      t.note  :string
      t.notes :text
      t.contact_flags :string, :default => '10100000'
      t.timestamps
    end
  end
end
