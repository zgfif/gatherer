require 'test_helper'
require 'capybara/rails'

class ShowsTwitterAvatar < ActionDispatch::IntegrationTest
  include Capybara::DSL

  setup do
    @user = FactoryBot.create(:user, twitter_handle: '_pav_k')
    @project = FactoryBot.create(:project)
    @project.roles.create(user: @user)
    FactoryBot.create(:task, completed_at: 1.hour.ago, project: @project, project_order: 1, user: @user)
    sign_in(@user)
  end

  test 'I see a gravatar' do
    VCR.use_cassette('loading_twitter') do
      visit project_path(@project)
      assert_current_path project_path(@project)
      url = "http://pbs.twimg.com/profile_images/2728851550/1243f1cb77cc0b3f57f6c8956c4aaf68_bigger.png"

      within("#task_1") do
        assert_selector(".completed", text: @user.email)
        assert_selector("img[src='#{url}']")
      end
    end
  end
end
