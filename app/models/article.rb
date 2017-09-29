class Article < ApplicationRecord
  validates_presence_of :author, :title, :subheading, :article_text

  def self.latest
    order(created_at: :desc).limit(3)
  end
end
