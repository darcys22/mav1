class AddDesiredToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :desired, :integer
  end
end
