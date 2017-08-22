class Thanks < ApplicationRecord
  scope :published_thanks, -> { where(published: true) }
  # scope :unpublished_thanks, -> { where(published: false) }
end
