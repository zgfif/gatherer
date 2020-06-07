class CreatesProject # this class allows to create project and task via the same form
  attr_accessor :name, :project, :task_string, :users

  def initialize(name: '', task_string: '', users:[])
    @name = name
    @task_string = task_string || ''
    @success = false
    @users = users
  end

  def success?
    @success
  end

  def build
    self.project = Project.new(name: name)
    project.add_users(users) unless users.empty?
  end

  def create
    build
    result = project_tasks_transaction
    @success = result
  end

  def project_tasks_transaction
    Project.transaction do
      return false unless project.save
      assign_tasks!
    end

    rescue ActiveRecord::RecordInvalid
      false
  end

  def assign_tasks!
    Task.transaction do
      convert_string_to_tasks.map do |task|
        task.project = project
        task.project_order = project.next_task_order
        task.save!
      end
    end
  end

  def convert_string_to_tasks
    task_string.split("\n").map do |one_task|
      title, size_string = one_task.split(':')
      Task.new(title: title, size: size_as_integer(size_string))
    end
  end

  def size_as_integer(size_string)
    return 1 if size_string.blank?
    [size_string.to_i, 1].max
  end
end
