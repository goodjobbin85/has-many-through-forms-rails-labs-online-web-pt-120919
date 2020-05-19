class Post < ActiveRecord::Base
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments
  has_many :users, through: :comments

  #accepts_nested_attributes_for :categories
  #use above line only if creating a new category every time
  #instead we will define custom category writee

  def categories_attributes=(category_attributes)
    category_attributes.values.each do |category_attribute|
      category = Category.find_or_create_by(category_attribute)
      self.categories << category if category.name != ""
    end
  end

  def uniq_users
    uniq_commenters = []
    self.comments.each do |comment|
      uniq_commenters << comment.user if !uniq_commenters.include?(comment.user)
    end
    uniq_commenters
  end

end
