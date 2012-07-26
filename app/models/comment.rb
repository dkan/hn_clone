class Comment < ActiveRecord::Base
  attr_accessible :article_id, :body, :parent_comment_id, :user_id
  belongs_to :article
  belongs_to :user
  belongs_to :comment, :class_name => 'Comment'
  has_many :comments, :foreign_key => 'parent_comment_id'
  has_many :votes, :as => :voteable

  validates_presence_of :body

  def upvotes
    self.votes.where(:value => 1)
  end

  def downvotes
    self.votes.where(:value => -1)
  end

  def score
    #the most negative score appears first in the array
    downvotes.length - upvotes.length
  end

  def comments_sorted_by_score
    self.comments.sort_by!(&:score)
  end
end
