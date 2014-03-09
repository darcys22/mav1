class AddShiftabletoShifts < ActiveRecord::Migration
  def change
    change_table :shifts do |t|
      t.references :shiftable, :polymorphic => true
    end
  end
end
