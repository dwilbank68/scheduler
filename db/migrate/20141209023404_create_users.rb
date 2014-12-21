class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name,  :required => true
      t.string :phone
      t.string :SMS
      t.string :email, :required => true

      t.timestamps
    end
  end
end
