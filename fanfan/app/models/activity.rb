class Activity < ActiveRecord::Base
  has_many :participations
  has_many :payers, :through => :payments, :source => :user
  has_many :payments
  validates_presence_of :subject
  validates_presence_of :status
  validates_presence_of :cost
  attr_accessible :subject, :status, :detail, :cost, :payers, :payments


  def payer_names
    return "" if payers.empty?
    return payers.map{|u| u.username}.join(",")
  end
end
