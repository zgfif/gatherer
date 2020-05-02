Given("existing user") do
  @user = FactoryBot.create(:user)
end

When("user signin") do
  expect(User.first).to eq(@user)
  visit new_user_session_path

  within '#new_user' do
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'
  end
end

When("fills new project's form") do
  visit new_project_path

  within '#new_project' do
    fill_in 'Name', with: 'Project Runaway'
    fill_in 'Tasks', with: "who i am:2\nHisenberg:3"
    click_button 'Create Project'
  end
end

Then("appears created project with tasks") do
  visit project_path(1)
  within '#task_1' do
    expect(page).to have_selector('.name', text: 'who i am')
    expect(page).to have_selector('.size', text: '2')
  end

  within '#task_2' do
    expect(page).to have_selector('.name', text: 'Hisenberg')
    expect(page).to have_selector('.size', text: '3')
  end
end
