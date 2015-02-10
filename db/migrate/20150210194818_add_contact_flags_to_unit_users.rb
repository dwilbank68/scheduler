class AddContactFlagsToUnitUsers < ActiveRecord::Migration
  def change
    add_column :unit_users, :contact_flags, :string
  end
end
