require "optparse"
require "shutwork/command/help"
require "shutwork/command/me"
require "shutwork/command/rooms"
require "shutwork/command/token"

module Shutwork
  class Cli
    def initialize args
      @args = args
    end

    def options
      @options ||= {}
    end

    def run
      opts = OptionParser.new
      opts.on("-v", "--version") do
        puts "Version: #{Shutwork::VERSION}"
        exit 0
      end
      opts.on("-h", "--help") do
        Shutwork::Command::Help.new.run
        return
      end


      opts.order! ARGV
      command = ARGV.shift

      case command
      when "me"
        Shutwork::Command::Me.new.run
      when "rooms"
        Shutwork::Command::Rooms.new.run
      when "token"
        Shutwork::Command::Token.new.run
      when nil
        Shutwork::Command::Help.new.run
      else
        puts "Unknown command: #{command}"
        Shutwork::Command::Help.new.run
        exit 1
      end
    end
  end
end
