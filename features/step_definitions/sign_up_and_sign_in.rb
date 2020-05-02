Given("email and password") do
  @email = 'example@gmail.com'
  @password = '123456'
end

When("fill the Singup form") do
  visit new_user_registration_path
  within '#new_user' do
    fill_in 'Email', with: 'example@gmail.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_button 'Sign up'
  end
  expect(page).to have_content('Welcome! You have signed up successfully.')
end

Then("I can regularly signin") do
  click_on('Sign Out')
  within '#new_user' do
    fill_in 'Email', with: 'example@gmail.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
  end
  expect(page).to have_content('Signed in successfully')
end
