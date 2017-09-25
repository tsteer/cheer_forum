class Article < ApplicationRecord
  validates_presence_of :author, :title, :subheading, :article_text
end
