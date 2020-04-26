require "json"
require "optparse"

require "shutwork/client"
require "shutwork/token"

module Shutwork
  module Command
    class Rooms
      def parse_args
        opts = OptionParser.new
        opts.program_name = "shutwork #{self.class.name.split(/::/).last.downcase}"
        opts.on("-r", "--raw", "Show results in raw format") { @raw = true }
        @arg, _ = opts.parse ARGV
      end

      def run
        token = Shutwork::Token.read
        @client = Shutwork::Client.new token: token

        parse_args
        if @arg
          show @arg
        else
          list
        end
      end

      def list
        items = @client.rooms
        if @raw
          puts items
        else
          rooms = JSON.parse(items)
          rooms.each do |room|
            puts ("%10s  %s" % [room["room_id"], room["name"]])
          end
        end
      end

      def show room_id
      end
    end
  end
end
