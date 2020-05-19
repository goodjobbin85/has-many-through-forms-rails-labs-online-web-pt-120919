class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  accepts_nested_attributes_for :user

  def user_attributes=(user)
    self.user = User.find_or_create_by(username: user[:username]) unless user[:username].blank?
  end
end
