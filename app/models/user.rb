class User < ActiveRecord::Base
  # validates_presence_of :token, :uname, :from

  before_save :generate_tokens

  def generate_tokens
    self.ipad_token = SecureRandom.uuid
    self.android_token = SecureRandom.uuid
    self.apple_token = SecureRandom.uuid
  end

  def self.find_by_channel_token(client_type, channel_token)
    case client_type
    when 1
      User.find_by(ipad_token: channel_token)
    when 2
      User.find_by(android_token: channel_token)
    when 3
      User.find_by(apple_token: channel_token)
    end
  end
end
