class Activity < ActiveRecord::Base
  has_many :participations
  has_many :users, :through => :participations
  has_many :payers, :through => :payments, :source => :user
  has_many :payments
  validates_presence_of :subject
  validates_presence_of :status
  validates_presence_of :cost
  attr_accessible :subject, :status, :detail, :users, :cost, :payers, :payments


  def user_names
    return "" if users.empty?
    return users.map{|u| u.name}.join(",")
  end
end
