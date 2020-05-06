Given("a logged-in user") do
  @user = FactoryBot.create(:user, twitter_handle: '_pav_k')
  @project = FactoryBot.create(:project)
  FactoryBot.create(:role, user: @user, project: @project)
  @task = FactoryBot.create(:task, :newly_complete, project: @project, user: @user, project_order: 1, user: @user)
end

When("the user completed a task") do
  login_as(@user)
end

When("I view the project's page") do
  visit project_path(@project)
end

Then("I should see the User's twitter avatar") do
  url = "http://pbs.twimg.com/profile_images/2728851550/1243f1cb77cc0b3f57f6c8956c4aaf68_bigger.png"
  within '#task_1' do
    expect(page).to have_selector(".completed", text: @user.email)
    expect(page).to have_selector("img[src='#{url}']")
  end
end
