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

    describe 'attaches tasks to the project' do
      let(:task_string) { "First Task:1\nSecond Task:4" }
      before(:example) { creator.create }
      specify { expect(creator.project.tasks.size).to eq(2) }
      specify { expect(creator.project).not_to be_a_new_record }
    end
  end
end
