class User < ApplicationRecord
  belongs_to :organisation
  validates :organisation_id, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { staff: 0, admin: 1 }
end
