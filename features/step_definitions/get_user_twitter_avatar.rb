Given("a logged-in user") do
  @user = FactoryBot.create(:user, twitter_handle: 'me')
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
  url = "https://platform-lookaside.fbsbx.com/platform/profilepic/?asid=3397113376983906&height=200&width=200&ext=1591291996&hash=AeT-GX7k6geF8DVi"
  within '#task_1' do
    expect(page).to have_selector(".completed", text: @user.email)
    expect(page).to have_selector("img[src='#{url}']")
  end
end
