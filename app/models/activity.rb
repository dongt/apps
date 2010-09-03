class Activity < ActiveRecord::Base
  has_many :participations
  has_many :users, :through => :participations
  attr_accessible :subject, :status, :detail, :users 
  

  def user_names
    return "" if users.empty?
    return users.map{|u| u.name}.join(",")
  end
end
