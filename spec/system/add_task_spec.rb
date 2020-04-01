require 'rails_helper'

RSpec.describe 'adding a new task' do
  let!(:project) { create(:project, name: 'Project NDP') }
  let!(:task1) { create(:task, title: 'Set adding text', size: 1, project: project) }
  let!(:task2) { create(:task, title: 'Set adding photos', size: 1, project: project) }

  it 'can add and reorder a task' do
    visit(project_path(project))
    fill_in('Task', with: 'Find UFOs')
    select('2', from: 'Size')
    click_on('Add Task')
    expect(current_path).to eq(project_path(project))

    within '#task_3' do
      expect(page).to have_selector('.name', text: 'Find UFOs')
      expect(page).to have_selector('.size', text: '2')
      expect(page).to have_selector('a', text: 'Down')
      click_on('Up')
    end

    expect(current_path).to eq(project_path(project))

    within '#task_2' do
      expect(page).to have_selector('.name', text: 'Find UFOs')
    end
  end
end
