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
        if @options[:raw]
          puts client.me.to_json
        else
          me = client.me
          puts ("%10s  %s" % [me["account_id"], me["name"]])
        end
      end
    end
  end
end
