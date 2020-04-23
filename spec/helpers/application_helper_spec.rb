require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  it 'should render Sign In reference' do
    allow(controller).to receive(:user_signed_in?).and_return(true)
    actual = helper.sign_in_out
    expect(actual).to have_selector('a', text: 'Sign Out')
  end

  it 'should render Sign Out reference' do
    allow(controller).to receive(:user_signed_in?).and_return(false)
    actual = helper.sign_in_out
    expect(actual).to have_selector('a', text: 'Sign In')
  end
end
