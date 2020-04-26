module Shutwork
  module Command
    class Help
      def run
        puts <<EOS
Usage: shutwork COMMAND

Available options:
  -h,--help                Show this help text
     --raw                 Show raw result

Available commands:
  me                       Me
  rooms                    Rooms
EOS
      end
    end
  end
end
