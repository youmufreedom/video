class Video < ApplicationRecord
  belongs_to :user
  belongs_to :organisation
  has_many :category_videos
  has_many :categories, through: :category_videos

  has_one_attached :file
  has_one_attached :thumbnail
  has_one_attached :overlay

  validates :file, presence: true
  validates :title, presence: true

  mount_uploader :file, VideoFileUploader
  mount_uploader :thumbnail, ThumbnailUploader
  mount_uploader :overlay, OverlayUploader
end
