class RenameColumn < ActiveRecord::Migration
  def change

    rename_column :units, :screenName, :screen_name

  end
end
