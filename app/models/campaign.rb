class Campaign < ActiveRecord::Base
  belongs_to :customer
  belongs_to :list
end
