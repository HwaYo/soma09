class Post < ActiveRecord::Base
  validates :link,
            :url => { message: "올바른 url을 입력해주세요." }

  validates :content, presence: { message: "상품 설명을 입력해주세요." }
  validates :max_participant_number, inclusion: { in: 2..20, message: "참여자 2 ~ 20명을 선택해주세요." }

  has_many :comments, -> { order(created_at: :asc) }, dependent: :destroy
  has_many :notifications, dependent: :destroy

  belongs_to :user, counter_cache: true

  has_many :participants
  has_many :users, through: :participants

  has_one :thumbnail

  def self.latest
    order(created_at: :desc)
  end

  def host
    if self.link
      uri = Addressable::URI.parse(self.link)
      uri.host
    else
      ""
    end
  end

  def link=(value)
    write_attribute(:link, Addressable::URI.heuristic_parse(value).to_s)
  end
end
