class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.string :subject
      t.string :status
      t.string :detail
      t.timestamps
    end
  end
  
  def self.down
    drop_table :activities
  end
end
