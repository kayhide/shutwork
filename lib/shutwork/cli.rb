require "optparse"
require "shutwork/command/help"
require "shutwork/command/me"

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
      opts.on("--output DIR")
      opts.on("--version") do
        puts "Version: #{Shutwork::VERSION}"
        return
      end
      opts.on("-h", "--help") do
        Shutwork::Command::Help.new.run
        return
      end
      command, _ = opts.parse!(@args, into: options)

      case command
      when "me"
        Shutwork::Command::Me.new(options).run
      when nil
        Shutwork::Command::Help.new.run
      else
        puts "Unknown command: #{command}"
        Shutwork::Command::Help.new.run
      end
    end
  end
end
