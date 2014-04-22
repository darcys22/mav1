class AddIgnoreToShift < ActiveRecord::Migration
  def change
    add_column :shifts, :ignore, :boolean
  end
end
