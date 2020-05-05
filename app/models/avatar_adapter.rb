class AvatarAdapter
  attr_accessor :user

  def initialize(user)
    @user = user
  end

  def graph
    Koala::Facebook::API.new(Rails.application.credentials[:facebook][:app_access_token])
  end

  def image_url
    graph.get_picture_data(user.twitter_handle, type: 'large')['data']['url']
  end
end
