class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.datetime :monstart
      t.datetime :monfinish
      t.datetime :tuestart
      t.datetime :tuefinish
      t.datetime :wedstart
      t.datetime :wedfinish
      t.datetime :thurstart
      t.datetime :thurfinish
      t.datetime :fristart
      t.datetime :frifinish
      t.datetime :satstart
      t.datetime :satfinish
      t.datetime :sunstart
      t.datetime :sunfinish

      t.timestamps
    end
  end
end
