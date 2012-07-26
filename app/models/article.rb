class Article < ActiveRecord::Base
  attr_accessible :title, :url
  URL_RULE = /^http/i
  belongs_to :user
  has_many :votes, :as => :voteable
  has_many :comments

  validates :url, :presence => true, :uniqueness => true, :format => { :with => URL_RULE, :message => 'Not a valid URL' }
  validates_presence_of :user_id, :title

  def score
    time_in_hours = (Time.now - self.created_at) / 3600
    num_votes = self.votes.length
    gravity = 1.8
    return -(num_votes) / ((time_in_hours + 2) ** gravity)
  end

  def top_level_comments
    self.comments.where(:parent_comment_id => nil).sort_by!(&:score)
  end

  def upvotes
    self.votes.where(:value => 1)
  end

  def too_late_to_edit?
    Time.now - self.created_at > 900
  end

end
