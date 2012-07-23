class Article < ActiveRecord::Base
  attr_accessible :title, :url
  URL_RULE = /^http/i


  validates :url, :presence => true, :uniqueness => true, :format => { :with => URL_RULE, :message => 'Not a valid URL' }


end
