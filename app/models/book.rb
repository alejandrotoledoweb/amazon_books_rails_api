class Book < ApplicationRecord
  validates :title, presence: true, uniqueness: true, length: { minimum: 3 }
  belongs_to :author

  # has_many :reviews, dependent: :destroy

  # def average_rating
  #   reviews.average(:rating)
  # end

  # def self.search(search)
  #   where("title ILIKE ? OR author ILIKE ?", "%#{search}%", "%#{search}%")
  # end
end
