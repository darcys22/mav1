class AddDesiredToUsers < ActiveRecord::Migration
  def change
    add_column :users, :desired, :integer
  end
end
