class CreateObservers < ActiveRecord::Migration
  def change
    create_table :observers do |t|
      t.references :schedule, index: true

      t.timestamps
    end
  end
end
