class Thanks < ApplicationRecord
  def self.published_thanks
    Thanks.where(published: true)
  end
end
