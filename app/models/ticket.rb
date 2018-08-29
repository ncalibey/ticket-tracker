class Ticket < ActiveRecord::Base
  STATUSES = %w(new block in_progress fixed)

  validates :name, presence: true
  validates :status, inclusion: { in: STATUSES }
  validates :project_id, presence: true

  belongs_to :project
  belongs_to :creator, class_name: "User"
  belongs_to :assignee, class_name: "User", optional: true
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :comments, dependent: :destroy

  scope :open, -> { where("status != ? ", "fixed") }
end
