class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :phone
      t.string :SMS
      t.string :email
      t.timestamp :start_time
      t.integer :duration
      t.text :note

      t.timestamps
    end
  end
end
