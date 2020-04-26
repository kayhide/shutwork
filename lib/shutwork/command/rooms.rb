require "shutwork/client"
require "shutwork/token"

module Shutwork
  module Command
    class Rooms
      def parse_args
        opts = OptionParser.new
        opts.program_name = "shutwork #{self.class.name.split(/::/).last.downcase}"
        opts.on("-r", "--raw", "Show results in raw format") { @raw = true }
        opts.parse ARGV
      end

      def run
        parse_args
        token = Shutwork::Token.read
        client = Shutwork::Client.new token: token
        if @raw
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
