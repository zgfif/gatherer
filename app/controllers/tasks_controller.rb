class TasksController < ApplicationController
  def create
    @task = Task.new(params[:task].permit(:title, :size, :project_id))
    redirect_to @task.project
  end
end
