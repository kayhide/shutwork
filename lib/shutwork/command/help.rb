module Shutwork
  module Command
    class Help
      def run
        puts <<EOS
Usage: shutwork COMMAND

Available options:
  -h,--help                Show this help text

Available commands:
  list                     List ...
EOS
      end
    end
  end
end
