require 'twitter'
begin
  require 'pi_piper'
rescue
  require 'pi_piper_mock'
end

Twitter.configure do |config|
  config.consumer_key = ENV['CONSUMER_KEY']
  config.consumer_secret = ENV['CONSUMER_SECRET']
  config.oauth_token = ENV['OAUTH_TOKEN']
  config.oauth_token_secret = ENV['OAUTH_TOKEN_SECRET']
end
user = Twitter.user

pin = PiPipper::Pin.new(pin: 17, direction: :out)

while active?
  sleep(5)
  action = gets "'check' or 'exit'?"
  case action
  when 'check'
    hashtags = user.status.hashtags
    if !hashtags.empty?
      if hashtags.include?("pi")
        if hashtags.include?("on")
          pin.on
        end
        if hashtags.include?("off")
          pin.on
        end
      end
    end
  when 'exit'
    @active = false
  else
    "Puts unknown action #{action}"
  end
end

def active?
  !!@active
end