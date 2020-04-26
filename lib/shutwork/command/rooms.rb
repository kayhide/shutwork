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
        opts.on("-v", "--verbose", "Verbose") { @verbose = true }
        opts.parse ARGV
      end

      def run
        @args = parse_args
        token = Shutwork::Token.read
        @client = Shutwork::Client.new token: token, verbose: @verbose

        if @args.first
          show @args.first
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
        items = @client.room_messages room_id
        if @raw
          puts items
        else
          messages = JSON.parse(items)
          messages.each do |message|
            puts "----------------"
            puts ("%s  %s" % [Time.at(message["send_time"]), message.dig("account", "name")])
            puts message["body"]
          end
        end
      end
    end
  end
end
