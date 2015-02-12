class AddContactFlagsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :contact_flags, :string
  end
end
