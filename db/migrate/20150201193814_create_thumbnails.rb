class CreateThumbnails < ActiveRecord::Migration
  def change
    create_table :thumbnails do |t|
      t.string :link, index: true
      t.string :title
      t.text :description
      t.text :images
      t.belongs_to :post, index: true
      t.timestamps null: false
    end
  end
end
