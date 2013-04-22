module Twitter

  class User
    def initialize
      
    end

    def status
      Status.new
    end
  end

  class Status
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
        "on"
      when 2
        "off"
      end
    end
  end

  def self.user
    User.new
  end

end