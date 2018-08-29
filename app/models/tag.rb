class Tag < ActiveRecord::Base
  validates :name, presence: true
  has_many :taggings, dependent: :destroy

  scope :with_counts, -> {
    left_outer_joins(:taggings).select("tags.*, COUNT(taggings.id)").
      group("tags.id")
  }

  scope :alphabetical, -> { order("tags.name ASC") }
end
