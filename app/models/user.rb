class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :remember_token
  has_secure_password
  has_many :articles
  has_many :comments

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  def karma
    self.articles.inject(0) { |count, article| count + article.upvotes.length } +
    self.comments.inject(0) { |count, comment| count + comment.upvotes.length }
  end

  def can_downvote?
    karma >= 100
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
