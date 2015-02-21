class AddNoteToUnits < ActiveRecord::Migration
  def change
    add_column :units, :note, :text
  end
end
