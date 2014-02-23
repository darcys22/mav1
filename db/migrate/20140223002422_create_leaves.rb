class CreateLeaves < ActiveRecord::Migration
  def change
    create_table :leaves do |t|
      t.datetime :start
      t.datetime :finish
      t.references :employee, index: true

      t.timestamps
    end
  end
end
