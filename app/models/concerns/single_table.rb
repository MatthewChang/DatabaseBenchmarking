class SingleTable < ActiveRecord::Base
  scope :active, -> { where(active: true) }
end
