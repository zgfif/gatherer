require 'rails_helper'

RSpec.describe CreatesProject do
  let(:creator) { CreatesProject.new(name: 'Project X', task_string: task_string) }

  describe 'initialization' do
    let(:task_string) { '' }

    it 'creates a project with a given name' do
      creator.build
      expect(creator.project.name).to eq('Project X')
    end
  end

  describe 'task string parsing' do
    let(:tasks) { creator.convert_string_to_tasks }

    describe 'handles an empty string' do
      let(:task_string) { '' }
      specify { expect(tasks).to be_empty }
    end

    describe 'handles a single string' do
      let(:task_string) { 'First Task' }
      specify { expect(tasks.size).to eq(1) }
      specify {expect(tasks.first).to have_attributes(title: 'First Task', size: 1) }
    end

    describe 'handles a single string with size' do
      let(:task_string) { 'First Task:3' }
      specify { expect(tasks.size).to eq(1) }
      specify { expect(tasks.first).to have_attributes(title: 'First Task', size: 3) }
    end

    describe 'handles a single string with zero size' do
      let(:task_string) { 'First Task:0' }
      specify { expect(tasks.size).to eq(1) }
      specify { expect(tasks.first).to have_attributes(title: 'First Task', size: 1) }
    end

    describe 'handles a single string with malformed size' do
      let(:task_string) { 'First Task:' }
      specify { expect(tasks.size).to eq(1) }
      specify { expect(tasks.first).to have_attributes(title: 'First Task', size: 1) }
    end

    describe 'handles a single string string with negative size' do
      let(:task_string) { 'First Task:-1' }
      specify { expect(tasks.size).to eq(1) }
      specify { expect(tasks.first).to have_attributes(title: 'First Task', size: 1) }
    end

    describe 'handles multiple tasks' do
      let(:task_string) { "First Task:1\nSecond Task:4" }
      specify { expect(tasks.size).to eq(2) }
      specify { expect(tasks).to match(
        [an_object_having_attributes(title: 'First Task', size: 1),
        an_object_having_attributes(title: 'Second Task', size: 4)]) }
    end

    describe "doesn't allow creation of a task without a size" do
      let(:task_string) { 'size:no_size' }
      before(:example) { creator.create }
      specify { expect(creator.project.tasks.map(&:title)).to eq(["size"]) }
    end

    describe 'attaches tasks to the project' do
      let(:task_string) { "First Task:1\nSecond Task:4" }
      before(:example) { creator.create }
      specify { expect(creator.project.tasks.size).to eq(2) }
      specify { expect(creator.project).not_to be_a_new_record }
    end
  end
end

describe "failure cases" do
  it "fails when trying to save a project with no name" do
    creator = CreatesProject.new(name: "", task_string: "")
    creator.create
   expect(creator).not_to be_a_success
  end
end

describe "mocking a failure" do
  it "fails when we say it fails" do
    project = instance_spy(Project, save: false)
    allow(Project).to receive(:new).and_return(project)
    creator = CreatesProject.new(name: "Name", task_string: "Task")
    creator.create
    expect(creator).not_to be_a_success
  end

end

describe 'project users' do
  it 'adds users to a project' do
    user = create(:user)
    creator = CreatesProject.new(name: 'Project Runway', users: [user])
    creator.build
    expect(creator.project.users).to eq([user])
  end
end
