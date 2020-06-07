class Task < ApplicationRecord
  include Sizeable #look at concerns/sizeable.rb

  belongs_to :project
  belongs_to :user, required: false

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

  def first_in_project?
    return false unless project
    project.tasks.first == self
  end

  def last_in_project?
    return false unless project
    project.tasks.last == self
  end

  def previous_task
    project.tasks.find_by(project_order: project_order - 1)
  end

  def next_task
    project.tasks.find_by(project_order: project_order + 1)
  end

  def swap_order_with(other)
    other.project_order, self.project_order = project_order, other.project_order
    save
    other.save
  end

  def move_up
    swap_order_with(previous_task) unless first_in_project?
  end

  def move_down
    swap_order_with(next_task) unless last_in_project?
  end
end
