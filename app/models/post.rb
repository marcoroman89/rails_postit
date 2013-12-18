class Post < ActiveRecord::Base
  include Sluggable
  include Voteable

  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  has_many :comments, dependent: :destroy, :order => "created_at DESC"
  has_many :post_categories
  has_many :categories, through: :post_categories

  validates :category_ids, presence: true

  validates :title,
    presence: true,
    length: {minimum: 5}

  validates :description, presence: true

  validates :url, presence: true,
    uniqueness: true

  sluggable_column :title
end
