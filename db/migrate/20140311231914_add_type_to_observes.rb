class AddTypeToObserves < ActiveRecord::Migration
  def change
    add_column :observes, :type, :string
  end
end
