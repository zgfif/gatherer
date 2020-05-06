class AvatarAdapter
  attr_accessor :user

  def initialize(user)
    @user = user
  end

  def client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.credentials[:twitter][:api_key]
      config.consumer_secret     = Rails.application.credentials[:twitter][:api_secret_key]
    end
  end

  def image_url
    client.user(user.twitter_handle).profile_image_uri(:bigger).to_s
  end
end
