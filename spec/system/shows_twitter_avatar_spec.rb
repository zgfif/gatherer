require 'rails_helper'

RSpec.describe 'task display' do
  let!(:project) { create(:project, name: 'Project Bluebook') }
  let!(:user) {create(:user, twitter_handle: '_pav_k')}
  let!(:task) { create(:task, project: project, user: user, completed_at: 1.hour.ago, project_order: 1) }

  before(:example) do
    project.roles.create(user: user)
    sign_in(user)
  end

  it 'shows a gravatar', :vcr, :slow do
    visit project_path(project)
    url = "http://pbs.twimg.com/profile_images/2728851550/1243f1cb77cc0b3f57f6c8956c4aaf68_bigger.png"
    within('#task_1') do
      expect(page).to have_selector('.completed', text: user.email)
      expect(page).to have_selector("img[src='#{url}']")
    end
  end
end
