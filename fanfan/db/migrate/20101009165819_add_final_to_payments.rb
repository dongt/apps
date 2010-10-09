class AddFinalToPayments < ActiveRecord::Migration
  def self.up
    add_column :payments, :final, :boolean
  end

  def self.down
    remove_column :payments, :final
  end
end
