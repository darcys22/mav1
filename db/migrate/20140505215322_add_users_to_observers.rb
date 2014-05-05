class AddUsersToObservers < ActiveRecord::Migration
  def change
    add_reference :observers, :user, index: true
  end
end
