class AddUsersToRosterings < ActiveRecord::Migration
  def change
    add_reference :rosterings, :user, index: true
  end
end
