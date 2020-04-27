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
        puts ("%s  %s" % [
          format_datetime(item["send_time"]),
          item.dig("account", "name")
        ])
        puts item["body"]
      end

      def display_file item
        puts ("%s  %6s  %s" % [
          format_datetime(item["upload_time"]),
          format_filesize(item["filesize"]),
          item["filename"]]
        )
      end

      def format_datetime x
        Time.at(x).to_s
      end

      def format_filesize x
        to_filesize_human x
      end

      def to_filesize_human x
        x = %w(KB MB GB TB).inject([x.to_f, 'B']) do |acc, u|
          v = acc.first / 1024
          if v.round(2) < 0.90
            acc
          else
            [v, u]
          end
        end
        if x.first >= 10.0 || x.last == 'B'
          "%.0f%s" % x
        else
          "%.1f%s" % x
        end
      end
    end
  end
end
