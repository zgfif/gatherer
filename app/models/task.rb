class Task < ApplicationRecord
  include Sizeable

  belongs_to :project

  def complete?
   completed_at.present?
  end

  def mark_completed(date = Time.current)
    self.completed_at = date
  end

  def part_of_velocity?
    return false unless complete?
    completed_at > Project.velocity_length_in_days.days.ago
  end

  def points_toward_velocity
    part_of_velocity? ? size : 0
  end
end
