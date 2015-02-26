class AddNotesToUnits < ActiveRecord::Migration
  def change
    add_column :units, :notes, :text
  end
end
