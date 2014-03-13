class AddTypeToObservers < ActiveRecord::Migration
  def change
    add_column :observers, :type, :string
  end
end
