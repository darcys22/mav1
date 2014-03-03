class AddBusinessIdToShift < ActiveRecord::Migration
  def change
    add_reference :shifts, :business, index: true
  end
end
