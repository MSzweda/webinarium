class Suggestion < ActiveRecord::Base

  belongs_to :user
  has_many :suggestion_votes

  validates :description, :user_id, presence: true

  scope :latest, -> { order(created_at: :desc) }

end
