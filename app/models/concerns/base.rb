class Base < ActiveRecord::Base
  belongs_to :data_item
  scope :active, -> { where(active: true) }
end
