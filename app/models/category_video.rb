class CategoryVideo < ApplicationRecord
  belongs_to :video
  belongs_to :category
end
