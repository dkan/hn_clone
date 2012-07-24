class Vote < ActiveRecord::Base
  attr_accessible :user_id, :voteable_id, :value
  belongs_to :voteable, :polymorphic => true
  belongs_to :user

  validates_uniqueness_of :user_id, :scope => [:voteable_id]
end
