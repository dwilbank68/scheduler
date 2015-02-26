class AddWhenDisabledToUnits < ActiveRecord::Migration
  def change
    add_column :units, :when_disabled, :datetime
  end
end
