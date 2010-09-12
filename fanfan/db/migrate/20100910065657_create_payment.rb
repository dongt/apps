class CreatePayment < ActiveRecord::Migration
  def self.up
    create_table :payments do |t|
      t.integer :activity_id
      t.integer :user_id
      t.decimal :amount 
    end
  end

  def self.down
    drop_table :payments
  end
end
