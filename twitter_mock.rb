module Twitter
  puts "Overriding Twitter"

  class User
    def initialize
    end
    def status
      Status.new
    end
  end

  class Status
    def initialize
    end
    def hashtags
      [Hashtag.pi, Hashtag.action].compact
    end
  end

  class Hashtag
    def self.pi
      "pi" if rand(2) == 0
    end

    def self.action
      random = rand(3)
      case random
      when 0
        nil
      when 1
        HashtagText.new("on")
      when 2
        HashtagText.new("off")
      end
    end
  end

  class HashtagText
    def initialize(text)
      @text = text
    end
    def text
      @text
    end
  end

  def self.user
    User.new
  end

end