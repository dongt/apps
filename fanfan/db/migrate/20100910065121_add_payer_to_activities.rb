class AddPayerToActivities < ActiveRecord::Migration
  def self.up
    add_column :activities, :payer_id, :integer
  end

  def self.down
    remove_column :activities, :payer_id
  end
end
