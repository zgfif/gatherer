require 'rails_helper'

RSpec.describe AvatarAdapter do
  it 'accurately receives image url', :vcr do
    user = instance_double(User, twitter_handle: 'me')
    adapter = AvatarAdapter.new(user)
    url = "https://platform-lookaside.fbsbx.com/platform/profilepic/?asid=3397113376983906&height=200&width=200&ext=1591290607&hash=AeQliZgx8VUdsFLt"
    expect(adapter.image_url).to eq(url)
  end
end
