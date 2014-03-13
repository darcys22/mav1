class CreateObserves < ActiveRecord::Migration
  def change
    create_table :observes do |t|
      t.references :schedule, index: true

      t.timestamps
    end
  end
end
