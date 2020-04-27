# Given 'a user' do
#   @user = User.create!(email: 'creed@gmail.com', password: 'password')
# end
#
# Given /a project named '(.*)'$/ do | project_name|
#   @project = Project.create!(name: project_name)
#   @project.roles.create(user: @user)
# end
#
# Given 'an associated tasks with attributes:' do |task_attrs|
#   @project.tasks.create!(task_attrs.hashes)
# end
#
# When 'the user sign in' do
#   visit new_user_session_path
#   fill_in "user_email", :with => 'creed@gmail.com'
#   fill_in "user_password", :with => 'password'
#   click_button "Log in"
# end
#
# When("I visit the project page") do
#   visit project_path(@project)
# end
#
# When("I complete the new task form") do
#   fill_in('Task', with: 'Find UFOs')
#   select('2', from: 'Size')
#   click_on('Add Task')
# end
#
# Then("I am back on the project page") do
#   expect(current_path).to eq(project_path(@project))
# end
#
# Then("I see the new task is last in the list") do
#   within '#task_3' do
#     expect(page).to have_selector('.name', text: 'Find UFOs')
#     expect(page).to have_selector('.size', text: '2')
#     expect(page).to_not have_selector('a', text: 'Up')
#     expect(page).to_not have_selector('a', text: 'Down')
#   end
# end
# #
# When("I click to move the new task up") do
#   within '#task_3' do
#      click_on('Up')
#   end
# end
#
# Then("the new task is in the middle of the list") do
#   within '#task_3' do
#     expect(page).to have_selector('.name', text: 'Find UFOs')
#     expect(page).to have_selector('a', text: 'Up')
#     expect(page).to have_selector('a', text: 'Down')
#   end
# end
