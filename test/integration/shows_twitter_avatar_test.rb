require 'test_helper'
require 'capybara/rails'

class ShowsTwitterAvatar < ActionDispatch::IntegrationTest
  include Capybara::DSL

  setup do
    @user = FactoryBot.create(:user, twitter_handle: 'me')
    @project = FactoryBot.create(:project)
    @project.roles.create(user: @user)
    FactoryBot.create(:task, completed_at: 1.hour.ago, project: @project, project_order: 1, user: @user)
    sign_in(@user)
  end

  test 'I see a gravatar' do
    VCR.use_cassette('loading_twitter') do
      visit project_path(@project)
      assert_current_path project_path(@project)
      url = "https://platform-lookaside.fbsbx.com/platform/profilepic/?asid=3397113376983906&height=200&width=200&ext=1591290875&hash=AeTZZyxxgtjJ9W_t"
      within("#task_1") do
        assert_selector(".completed", text: @user.email)
        assert_selector("img[src='#{url}']")
      end
    end
  end
end
