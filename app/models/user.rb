class User < ApplicationRecord
  has_many :roles, dependent: :destroy
  has_many :projects, through: :roles
  has_many :tasks, dependent: :nullify

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def can_view?(project)
    project.in?(visible_projects)
  end

  def visible_projects
    return Project.all if admin
    Project.where(id: project_ids).or(Project.all_public)
  end
end
