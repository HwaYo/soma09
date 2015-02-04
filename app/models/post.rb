class Post < ActiveRecord::Base
  validates :link, presence: { message: "상품 링크를 입력해주세요." }
  validates :content, presence: { message: "상품 설명을 입력해주세요." }


  has_many :comments, dependent: :destroy

  belongs_to :user, counter_cache: true

  has_many :participants
  has_many :users, through: :participants

  def self.latest
    order(created_at: :desc)
  end

  def host
    if self.link
      uri = URI(self.link)
      uri.host
    else
      ""
    end
  end
end
