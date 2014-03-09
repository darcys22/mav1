class RemoveBusinessIdFromShift < ActiveRecord::Migration
  def change
    remove_column :shifts, :business_id
  end
end
