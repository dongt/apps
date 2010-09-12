class AddCostToActivities < ActiveRecord::Migration
  def self.up
    add_column :activities, :cost, :decimal
  end

  def self.down
    remove_column :activities, :cost
  end
end
