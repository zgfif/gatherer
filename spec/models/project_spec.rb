require 'rails_helper'

# require_relative '../active_record_test_helper'

RSpec.describe Project do
  let(:project) { Project.new }
  let(:task) { Task.new }

  it "considers a project with no tasks to be done" do
    expect(project).to be_done
  end

  it "knows that a project with an incomplete task is not done" do
    project.tasks << task
    expect(project).to_not be_done
  end

  it 'marks project done if its tasks are done' do
    task.mark_completed
    project.tasks << task
    expect(project).to be_done
  end
end

describe 'estimates' do
  let(:project) { FactoryBot.build_stubbed(:project, tasks: [newly_done, old_done, small_not_done, large_not_done]) }
  let(:newly_done) { FactoryBot.build_stubbed(:panic) }
  let(:old_done) { FactoryBot.build_stubbed(:trivial) }
  let(:small_not_done) { FactoryBot.build_stubbed(:task, :small) }
  let(:large_not_done) { FactoryBot.build_stubbed(:task, :large) }

  it "can calculate total size" do
    expect(project).to be_of_size(10)
    expect(project).not_to be_of_size(5)
  end

  it "can calculate remaining size" do
    expect(project).to be_of_size(5).for_incomplete_tasks_only
  end

  it "knows its velocity" do
    expect(project.completed_velocity).to eq(4)
  end

  it "knows its rate" do
    expect(project.current_rate).to eq(4.0 / 21)
  end

  it "knows its projected days remaining" do
    expect(project.projected_days_remaining).to eq(26.25)
  end

  it "knows if it is not on schedule" do
    project.due_date = 1.week.from_now
    expect(project).not_to be_on_schedule
  end

  it "knows if it is on schedule" do
    project.due_date = 6.months.from_now
    expect(project).to be_on_schedule
  end
end

describe 'without task' do
  let(:project) { FactoryBot.build_stubbed(:project) }

  it "considers a project with no tasks to be done" do
    expect(project).to be_done
  end

  it "properly handles a blank project" do
    expect(project.completed_velocity).to eq(0)
    expect(project.current_rate).to eq(0)
    expect(project.projected_days_remaining).to be_nan
    expect(project).not_to be_on_schedule
  end
end

describe "with a task" do
  let(:project) { FactoryBot.build_stubbed(:project, tasks: [task]) }
  let(:task) { FactoryBot.build_stubbed(:task) }

   it "knows that a project with an incomplete task is not done" do
    expect(project).not_to be_done
   end

  it "marks a project done if its tasks are done" do
    task.mark_completed
    expect(project).to be_done
  end
end

describe 'doubles' do
  it 'should be a full double' do
    instance_twin = class_double(Project, all: 'Hello', find: '24-03-2020')
    expect(instance_twin.all).to eq('Hello')
  end

  it "stubs an object" do
   project = Project.new(name: "Project Greenlight")
   allow(project).to receive(:name)
   expect(project.name).to be_nil
  end

  it "stubs an object again" do
    project = Project.new(name: "Project Greenlight")
    allow(project).to receive(:name).and_return("Fred")
    expect(project.name).to eq("Fred")
  end

  it "stubs the class" do
    allow(Project).to receive(:find).and_raise(ActiveRecord::RecordNotFound)
    allow(Project).to receive(:find).with(1).and_return(
      Project.new(name: "Project Greenlight"))
    allow(Project).to receive(:find).with(3).and_return(
      Project.new(name: "Project Greenlight"))
    project = Project.find(1)
    expect(project.name).to eq("Project Greenlight")
  end

  it "mocks an object" do
    mock_project = Project.new(name: "Project Greenlight")
    expect(mock_project).to receive(:name).and_return("Fred").twice
    expect(mock_project.name).to eq("Fred")
    expect(mock_project.name).to eq("Fred")
  end


  describe "task order" do
    let(:project) { create(:project, name: "Project") }

    it "makes 1 the order of the first task in an entry project" do
       expect(project.next_task_order).to eq(1)
    end

    it "gives the order of the next task as one more than the highest" do
      project.tasks.create(project_order: 1)
      project.tasks.create(project_order: 3)
      project.tasks.create(project_order: 2)
      expect(project.next_task_order).to eq(4)
    end
  end
end
