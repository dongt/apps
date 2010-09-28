class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.string :subject
      t.datetime :sent_date
      t.integer :sender_id
      t.integer :receiver_id
      t.string :status
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
