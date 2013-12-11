class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username,
    presence: true,
    length: { within: 5..20 },
    uniqueness: true

  validates :password,
    presence: true,
    on: :create,
    length: { minimum: 5 }

  validates_format_of :username, with: /\A[A-Za-z\d_]+\z/, message: "can only include letters and numbers"

  after_validation :generate_slug

  def admin?
    self.role == "admin"
  end

  def generate_slug
    self.slug = self.username.gsub(' ', '-').downcase
  end

  def to_param
    self.slug
  end
end
