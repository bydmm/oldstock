module Sinatra
  module Auth
    module Helpers
      def current_user
        token = request.env['HTTP_X_TOKEN']
        User.find_by(token: token)
      end
    end

    def self.registered(app)
      app.helpers Auth::Helpers
    end
  end

  register Auth
end
