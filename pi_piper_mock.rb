module PiPiper
  class Pin
    def initialize(options = {})
      
    end

    def method_missing(meth, *args, &block)
      puts "Would be calling '#{meth}' with '#{args.inspect}'"
    end
  end
end