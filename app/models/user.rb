class User < ActiveRecord::Base

  has_many :webinars
  has_many :votes
  has_many :stars
  has_many :suggestions

end
