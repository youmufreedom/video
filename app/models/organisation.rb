class Organisation < ApplicationRecord
  has_many :users
  has_many :videos
end
