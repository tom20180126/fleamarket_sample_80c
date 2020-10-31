class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  has_many :images
  accepts_nested_attributes_for :images, allow_destroy: true
  belongs_to :category
  belongs_to :user
  belongs_to_active_hash :size
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipping_days
  belongs_to_active_hash :shipping_cost
  belongs_to_active_hash :condition
end
