class Vote < ActiveRecord::Base
  attr_accessible :user_id, :voteable_id, :voteable_type, :value
  belongs_to :voteable, :polymorphic => true
  belongs_to :user

  validates_uniqueness_of :user_id, :scope => [:voteable_id, :voteable_type], :message => "You can't vote twice"

  validate :check_karma

  def check_karma
    if !self.user.can_downvote? && self.value == -1
      errors.add(:base, "You need more karma to downvote")
    end
  end
end