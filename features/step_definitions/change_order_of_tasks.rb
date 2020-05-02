Given("existing project with {int} tasks") do |int|
   @user = FactoryBot.create(:user)
   @project = FactoryBot.create(:project)
   Role.create(user: @user, project: @project)

   int.times do |i|
     FactoryBot.create(:task, title: "task_#{i+1}", project: @project, size: rand(1..4), project_order: i+1)
   end
end

When("moves up the second task of the project") do
  login_as(@user)
  visit project_path(@project)
end

Then("the second task becomes first in order") do
  within '#task_2' do
    expect(page).to have_selector('.name', text: 'task_2')
    click_button 'Up'
  end

   within '#task_1' do
     expect(page).to have_selector('.name', text: 'task_2')
   end
end

And ("after reloading order is the same") do
  visit current_path
  within '#task_1' do
    expect(page).to have_selector('.name', text: 'task_2')
  end
end
