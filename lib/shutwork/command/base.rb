require "forwardable"
require "open-uri"
require "thor/shell/color"

require "shutwork/command/display"

module Shutwork
  module Command
    class Base
      extend Forwardable

      def_delegators :@shell, :say, :say_status

      include Display

      def initialize
        @shell = Thor::Shell::Color.new
      end

      def download_file url, dst, at = nil
        FileUtils.mkdir_p dst.dirname
        open(url) do |i|
          open(dst, 'wb') do |o|
            o.write i.read
          end
          if at
            File.utime at, at, dst
          end
        end
      end
    end
  end
end
