class Product < ActiveRecord::Base
  jsonb_accessor :data, 
    title: :string,
    value: :integer,
    store_id: :integer
end
