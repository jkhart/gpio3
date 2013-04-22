require 'twitter'
begin
  require 'pi_piper'
rescue LoadError
  require './pi_piper_mock'
end

puts ENV.inspect

begin
  Twitter.configure do |config|
    config.consumer_key = ENV['CONSUMER_KEY']
    config.consumer_secret = ENV['CONSUMER_SECRET']
    config.oauth_token = ENV['OAUTH_TOKEN']
    config.oauth_token_secret = ENV['OAUTH_TOKEN_SECRET']
  end
  user = Twitter.user
rescue Exception => exception
  puts exception.message
  require './twitter_mock'
  user = Twitter.user
end

pin = PiPiper::Pin.new(pin: 17, direction: :out)

@active = true

def active?
  !!@active
end

while active?
  sleep(3)
  #puts "'check' or 'exit'?"
  action = 'check'
  case action
  when 'check'
    user = Twitter.user
    status = user.status
    puts status.inspect
    hashtags = status.hashtags.collect(&:text)
    if !hashtags.empty?
      puts hashtags.inspect
      if hashtags.include?("pi")
        if hashtags.include?("on")
          pin.on
        end
        if hashtags.include?("off")
          pin.off
        end
      end
    end
  when 'exit'
    @active = false
  else
    "Puts unknown action #{action}"
  end
end

