class Admin < ApplicationRecord
  self.primary_key = :login
  has_secure_password
  validates :login, presence: true
  validates :password, length: {minimum: 6}

  def self.encrypt(str)
    Digest::SHA1.hexdigest str
  end
end
