class Comment < ActiveRecord::Base
  belongs_to :post
  validates :body, presence: true, length: { minimum: 1 }
  default_scope -> { order('created_at ASC') }
end
