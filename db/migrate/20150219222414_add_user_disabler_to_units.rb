class AddUserDisablerToUnits < ActiveRecord::Migration
  def change
    add_column :units, :user_disabler, :string
  end
end
