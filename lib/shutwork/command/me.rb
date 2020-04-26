require "shutwork/client"
require "shutwork/token"

module Shutwork
  module Command
    class Me
      def initialize options = {}
        @options = options
      end

      def run
        token = Shutwork::Token.read
        client = Shutwork::Client.new token: token
        puts client.me.to_json
      end
    end
  end
end
