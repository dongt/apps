class User < ActiveRecord::Base
  has_many :participations
  has_many :activities, :through => :participations
  attr_accessible :name, :email, :password

end
