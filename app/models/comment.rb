class Comment < ActiveRecord::Base
  belongs_to :creator, class_name: "User"
  belongs_to :ticket

  validates :body, presence: true
end
