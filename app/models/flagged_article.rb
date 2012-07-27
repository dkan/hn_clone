class FlaggedArticle < ActiveRecord::Base
  attr_accessible :article_id

  belongs_to :article

  validates_uniqueness_of :article_id
end
