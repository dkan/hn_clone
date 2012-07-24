class Article < ActiveRecord::Base
  attr_accessible :title, :url
  URL_RULE = /^http/i
  belongs_to :user

  validates :url, :presence => true, :uniqueness => true, :format => { :with => URL_RULE, :message => 'Not a valid URL' }
  validates_presence_of :user_id

end
