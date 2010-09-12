class User < ActiveRecord::Base
  has_many :participations
  has_many :activities, :through => :participations
  has_many :payments

  attr_accessible :name, :email, :password

end
