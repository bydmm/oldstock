module Sinatra
  module Utility
    module Helpers
      def love?(code, love_power, hard)
        unix_time = Time.now.beginning_of_minute.to_i
        raw_data = "#{unix_time}#{code}#{love_power}"
        hash = Digest::SHA512.hexdigest(raw_data)
        hash.match(/0{#{hard}}$/)
      end
    end

    def self.registered(app)
      app.helpers Utility::Helpers
    end
  end

  register Utility
end
