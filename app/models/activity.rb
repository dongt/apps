class Activity < ActiveRecord::Base
  has_many :participations
  has_many :users, :through => :participations
  attr_accessible :subject, :status, :detail, :users 
  
end
