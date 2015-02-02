class AddUnitPicToUnits < ActiveRecord::Migration
  def change
    add_column :units, :unit_pic, :string
  end
end
