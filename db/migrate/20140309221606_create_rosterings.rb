class CreateRosterings < ActiveRecord::Migration
  def change
    create_table :rosterings, :id => false do |t|
      t.references :employee, index: true
      t.references :schedule, index: true

      t.timestamps
    end
  end
end
