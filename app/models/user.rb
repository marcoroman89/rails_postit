class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  after_validation :generate_slug

  validates :username,
    presence: true,
    length: { within: 5..20 },
    uniqueness: true
    validates_format_of :username, with: /\A[A-Za-z0-9]+\Z/, message: "can only include letters and numbers"

  validates :password,
    presence: true,
    on: :create,
    length: { minimum: 5 }

  validates :github_profile,
    presence: true,
    on: :create,
    uniqueness: true

  validates :email,
    presence: true,
    uniqueness: true
    validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "doesn't look like a valid address"

  def admin?
    self.role == "admin"
  end

  def generate_slug
    self.slug = self.username.gsub(' ', '-').downcase
  end

  def to_param
    self.slug
  end

  def gravatar_url
    stripped_email = email.strip
    downcased_email = stripped_email.downcase
    hash = Digest::MD5.hexdigest(downcased_email)

    "http://gravatar.com/avatar/#{hash}"
  end
end
