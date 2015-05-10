class RemoveNoteFromUnits < ActiveRecord::Migration
  def change
    remove_column :units, :note
  end
end
