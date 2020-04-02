class CreatesProject
  attr_accessor :name, :project, :task_string

  def initialize(name: '', task_string: '')
    @name = name
    @task_string = task_string || ''
    @success = false
  end

  def success?
    @success
  end

  def build
    self.project = Project.new(name: name)
  end

  def create
    build
    result = Project.transaction do
      return false unless project.save

      convert_string_to_tasks.each do |task|
        task.project = project
        task.project_order = project.next_task_order
        return false unless task.save
      end
    end

    @success = result
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
