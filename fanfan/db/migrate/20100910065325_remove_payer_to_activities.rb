class RemovePayerToActivities < ActiveRecord::Migration
  def self.up
    remove_column :activities, :payer_id
  end

  def self.down
    add_column :activities, :payer_id, :integer
  end
end
