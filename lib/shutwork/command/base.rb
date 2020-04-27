require "forwardable"

require "thor/shell/color"

module Shutwork
  module Command
    class Base
      extend Forwardable

      def_delegators :@shell, :say, :say_status

      def initialize
        @shell = Thor::Shell::Color.new
      end

      def display_account item
        puts ("%10s  %s" % [item["account_id"], item["name"]])
      end

      def display_room item
        puts ("%10s  %s" % [item["room_id"], item["name"]])
      end

      def display_message item
        puts "----------------"
        puts ("%s  %s" % [Time.at(item["send_time"]), item.dig("account", "name")])
        puts item["body"]
      end
    end
  end
end
