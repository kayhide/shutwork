require "json"
require "optparse"

require "shutwork/client"
require "shutwork/token"

module Shutwork
  module Command
    class Me
      def parse_args
        opts = OptionParser.new
        opts.program_name = "shutwork #{self.class.name.split(/::/).last.downcase}"
        opts.on("-r", "--raw", "Show results in raw format") { @raw = true }
        opts.on("-v", "--verbose", "Verbose") { @verbose = true }
        opts.parse ARGV
      end

      def run
        parse_args
        token = Shutwork::Token.read
        @client = Shutwork::Client.new token: token, verbose: @verbose

        item = @client.me
        if @raw
          puts item
        else
          me = JSON.parse(item)
          puts ("%10s  %s" % [me["account_id"], me["name"]])
        end
      end
    end
  end
end
