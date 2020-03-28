require 'rails_helper'

RSpec.describe CreatesProject do
  it 'creates a project with a given name' do
    creator = CreatesProject.new(name: 'Wayne')
    creator.build
    expect(creator.project.name).to eq('Wayne')
  end
end

describe 'string parsing' do
  it 'handles an empty string' do
    creator = CreatesProject.new(name: 'Project X', task_string: '')
    tasks = creator.convert_string_to_tasks
    expect(tasks).to be_empty
  end

  it 'handles a single string' do
    creator = CreatesProject.new(name: 'Project X', task_string: 'First Task')
    tasks = creator.convert_string_to_tasks
    expect(tasks.size).to eq(1)
    expect(tasks.first).to have_attributes(title: 'First Task', size: 1)
  end

  it 'handles a single string with size' do
    creator = CreatesProject.new(name: 'Project X', task_string: 'First Task:3')
    tasks = creator.convert_string_to_tasks
    expect(tasks.size).to eq(1)
    expect(tasks.first).to have_attributes(title: 'First Task', size: 3)
  end

  it 'handles a single string with zero size' do
    creator = CreatesProject.new(name: 'Project X', task_string: 'First Task:0')
    tasks = creator.convert_string_to_tasks
    expect(tasks.size).to eq(1)
    expect(tasks.first).to have_attributes(title: 'First Task', size: 1)
  end

  it 'handles a single string with malformed size' do
    creator = CreatesProject.new(name: 'Project X', task_string: 'First Task:')
    tasks = creator.convert_string_to_tasks
    expect(tasks.size).to eq(1)
    expect(tasks.first).to have_attributes(title: 'First Task', size: 1)
  end

  it 'handles a single string string with negative size' do
    creator = CreatesProject.new(name: 'Project X', task_string: 'First Task:-1')
    tasks = creator.convert_string_to_tasks
    expect(tasks.size).to eq(1)
    expect(tasks.first).to have_attributes(title: 'First Task', size: 1)
  end

  it 'handles multiple tasks' do
    creator = CreatesProject.new(name: 'Project X', task_string: "First Task:1\nSecond Task:4")
    tasks = creator.convert_string_to_tasks
    expect(tasks.size).to eq(2)
    expect(tasks).to match(
      [an_object_having_attributes(title: 'First Task', size: 1),
        an_object_having_attributes(title: 'Second Task', size: 4)])
  end

  it 'attaches tasks to the project' do
    creator = CreatesProject.new(name: 'Project X', task_string: "First Task:1\nSecond Task:4")
    creator.create
    expect(creator.project.tasks.size).to eq(2)
    expect(creator.project).not_to be_a_new_record
  end
end
