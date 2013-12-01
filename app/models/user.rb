class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true,
                       length: { within: 5..20 },
                       uniqueness: true

  validates :password, presence: true,
                       length: { within: 5..20 }

  validates_format_of :username, with: /\A[A-Za-z\d_]+\z/, message: "can only include letters and numbers"
  validates_format_of :password, with: /\A[A-Za-z\d_]+\z/, message: "can only include letters and numbers"
end
