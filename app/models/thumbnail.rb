class Thumbnail < ActiveRecord::Base
  serialize :images, Array
  belongs_to :post
end
