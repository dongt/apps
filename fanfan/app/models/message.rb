class Message < ActiveRecord::Base
  validates_presence_of :subject
end
