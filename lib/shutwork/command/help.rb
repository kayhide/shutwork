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

Available commands:
  me                       Show me
  rooms                    Show Rooms and messages
  token                    Manage token
EOS
      end
    end
  end
end
