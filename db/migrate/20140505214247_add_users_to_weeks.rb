class AddUsersToWeeks < ActiveRecord::Migration
  def change
    add_reference :weeks, :user, index: true
  end
end
