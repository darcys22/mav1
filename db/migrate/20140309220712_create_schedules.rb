class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.references :week, index: true

      t.timestamps
    end
  end
end
