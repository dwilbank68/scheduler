class RemoveNameFromUnits < ActiveRecord::Migration
  def change
    remove_column :units, :name, :string
  end
end
