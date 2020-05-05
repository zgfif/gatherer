require 'rails_helper'

RSpec.describe 'task display' do
  let(:project) { create(:project, name: 'Project Bluebook') }
  let(:user) {create(:user, twitter_handle: 'me')}
  let!(:task) { create(:task, project: project, user: user, completed_at: 1.hour.ago, project_order: 1) }

  before(:example) do
    project.roles.create(user: user)
    sign_in(user)
  end

  it 'shows a gravatar', :vcr do
    visit project_path(project)
    url = 'https://platform-lookaside.fbsbx.com/platform/profilepic/?asid=3397113376983906&height=200&width=200&ext=1591290610&hash=AeS8f2f9sCd2hOam'
    within('#task_1') do
      expect(page).to have_selector('.completed', text: user.email)
      expect(page).to have_selector("img[src='#{url}']")
    end
  end
end
