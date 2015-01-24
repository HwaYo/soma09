class Comment < ActiveRecord::Base
  validates :content, presence: { message: "댓글을 입력해 주세요." }
  
  belongs_to :user, counter_cache: true
  belongs_to :post, counter_cache: true
end
