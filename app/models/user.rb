class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :timeoutable

  validates_presence_of :name
  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :is_admin, :password, :password_confirmation, :remember_me
  has_many :articles
  has_many :comments
  has_one  :banned_user

  def karma
    self.articles.inject(0) { |count, article| count + article.upvotes.length } +
    self.comments.inject(0) { |count, comment| count + comment.upvotes.length }
  end

  def can_downvote?
    karma >= 100
  end

  def admin?
    self.is_admin
  end

  def banned?
    self.banned_user
  end

  def active_for_authentication?
    super && !self.banned?
  end

  def inactive_message
    !self.banned? ? super : "You've been banned!"
  end


  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
