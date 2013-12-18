class Category < ActiveRecord::Base
  include Sluggable

  has_many :post_categories, :order => "created_at DESC"
  has_many :posts, through: :post_categories

  validates :name, presence: true, uniqueness: true

  sluggable_column :name
end
