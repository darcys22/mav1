class CreateRosterings < ActiveRecord::Migration
  def change
    create_table :rosterings, :id => false do |t|
      t.references :employee, index: true, :unique => true
      t.references :schedule, index: true, :unique => true

      t.timestamps
    end
  end
end
