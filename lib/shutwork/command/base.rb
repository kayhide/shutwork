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
    end
  end
end
