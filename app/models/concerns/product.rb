class Product < ActiveRecord::Base
  jsonb_accessor :data, 
    title: :string,
    value: :integer,
    store_id: :integer
  scope :active, -> { where(active: true) }
end
