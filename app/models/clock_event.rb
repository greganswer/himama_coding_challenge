class ClockEvent < ApplicationRecord
  belongs_to :user

  scope :latest, -> { order(created_at: :desc) }
  
  def clocked_in?
    !clock_out_at
  end
end
