require "json"
require "optparse"

require "shutwork/client"
require "shutwork/command/base"
require "shutwork/token"

module Shutwork
  module Command
    class Me < Base
      def parse_args args
        opts = OptionParser.new
        opts.program_name = "shutwork #{self.class.name.split(/::/).last.downcase}"
        opts.on("-r", "--raw", "Show results in raw format") { @raw = true }
        opts.on("-v", "--verbose", "Verbose") { @verbose = true }
        opts.parse args
      end

      def run args  = []
        parse_args args
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
