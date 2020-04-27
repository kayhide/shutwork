require "json"
require "optparse"

require "shutwork/client"
require "shutwork/command/base"
require "shutwork/token"

module Shutwork
  module Command
    class Rooms < Base
      def parse_args args
        opts = OptionParser.new
        opts.program_name = "shutwork #{self.class.name.split(/::/).last.downcase}"
        opts.on("-r", "--raw", "Show results in raw format") { @raw = true }
        opts.on("-v", "--verbose", "Verbose") { @verbose = true }
        opts.parse args
      end

      def run args = []
        @args = parse_args args
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
          JSON.parse(items).each(&method(:display_room))
        end
      end

      def show room_id
        items =
          case @target
          when :members
          else
            @client.room_messages room_id
          end
        if @raw
          puts items
        else
          JSON.parse(items).each(&method(:display_message))
        end
      end
    end
  end
end
