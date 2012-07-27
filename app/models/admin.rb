class Admin < ActiveRecord::Base
  attr_accessible :user_id
  belongs_to :user

  validates_uniqueness_of :user_id
end
