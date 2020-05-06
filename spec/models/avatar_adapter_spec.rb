require 'rails_helper'

RSpec.describe AvatarAdapter do
  it 'accurately receives image url', :vcr do
    user = instance_double(User, twitter_handle: '_pav_k')
    adapter = AvatarAdapter.new(user)
    url = "http://pbs.twimg.com/profile_images/2728851550/1243f1cb77cc0b3f57f6c8956c4aaf68_bigger.png"
    expect(adapter.image_url).to eq(url)
  end
end
