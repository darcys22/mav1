class CreateRosterings < ActiveRecord::Migration
  def change
    create_table :rosterings do |t|
      t.belongs_to :employee, :unique => true
      t.belongs_to :schedule, :unique => true

      t.timestamps
    end

  end
end
