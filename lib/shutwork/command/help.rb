require "shutwork/command/base"

module Shutwork
  module Command
    class Help < Base
      def run
        puts <<EOS
Usage: shutwork COMMAND

Available options:
  -h,--help                Show this help text
     --version             Show version
  -r,--raw                 Show result in raw format

Available commands:
  me                       Me
  rooms                    Rooms
EOS
      end
    end
  end
end
