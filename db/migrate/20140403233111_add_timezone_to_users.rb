class AddTimezoneToUsers < ActiveRecord::Migration
  def change
    add_column :users, :timezone, :string, :default => "Pacific Time (US & Canada)"
  end
end
