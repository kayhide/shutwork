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

    rescue Shutwork::AuthError
      $stderr.puts "Chatwork Token is invalid or not supplied."
      $stderr.puts
      $stderr.puts "1. Get your token as instructed:"
      $stderr.puts "  https://help.chatwork.com/hc/ja/articles/115000172402-API%E3%83%88%E3%83%BC%E3%82%AF%E3%83%B3%E3%82%92%E7%99%BA%E8%A1%8C%E3%81%99%E3%82%8B"
      $stderr.puts
      $stderr.puts "2. Set it as:"
      $stderr.puts "  shutwork token <YOUR_TOKEN>"
      $stderr.puts
      $stderr.puts "3. Check if it works as:"
      $stderr.puts "  shutwork me"
      $stderr.puts
    end
  end
end
