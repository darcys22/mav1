class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.date :date
      t.references :week, index: true

      t.timestamps
    end
  end
end
