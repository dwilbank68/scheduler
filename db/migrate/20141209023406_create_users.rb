class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, :null => false
      t.string :country
      t.string :phone
      t.string :phone2
      t.string :email
      t.string :email2
      t.string :sms
      t.string :role
      t.string :timezone
      t.string :avatar

      t.timestamps
    end
  end
end
