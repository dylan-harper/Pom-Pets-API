class AddSettingsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :settings, :hstore, default: {workTime: 0, shortPomTime: 0, longPomTime: 0}, null: false
  end
end
