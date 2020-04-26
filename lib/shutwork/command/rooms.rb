require "shutwork/client"
require "shutwork/token"

module Shutwork
  module Command
    class Rooms
      def initialize options = {}
        @options = options
      end

      def run
        token = Shutwork::Token.read
        client = Shutwork::Client.new token: token
        if @options[:raw]
          puts client.rooms
        else
          client.rooms.each do |room|
            puts ("%10s  %s" % [room["room_id"], room["name"]])
          end
        end
      end
    end
  end
end
