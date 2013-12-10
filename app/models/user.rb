class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  after_validation :generate_slug

  validates :username, presence: true,
                       length: { within: 5..20 },
                       uniqueness: true

  validates :password, presence: true,
                       length: { within: 5..20 }

  validates_format_of :username, with: /\A[A-Za-z\d_]+\z/, message: 'can only include letters and numbers'
  validates_format_of :password, with: /\A[A-Za-z\d_]+\z/, message: 'can only include letters and numbers'


  def admin?
    self.role.to_s.to_sym == :admin
  end

  def moderator?
    self.role == 'moderator?'
  end

  def generate_slug
    self.slug = self.username.gsub(' ', '-').downcase
  end

  def to_param
    self.slug
  end
end
