require "shutwork/command/base"
require "shutwork/token"

module Shutwork
  module Command
    class Token < Base
      def parse_args args
        opts = OptionParser.new
        opts.program_name = "shutwork #{self.class.name.split(/::/).last.downcase} [TOKEN]"
        opts.on("--skip-verify", "Skips validity check") { @skip_verify = true }
        opts.on("-v", "--verbose", "Verbose") { @verbose = true }
        opts.parse args
      end

      def run args = []
        @token = parse_args(args).first&.strip

        if @token
          unless @skip_verify
            verify_token!
          end
          Shutwork::Token.store @token
          say_status "save", Shutwork::Token.token_path, :green
        else
          token_ = Shutwork::Token.from_user_default
          if token_
            puts token_
          else
            puts "(Token is not stored)"
          end
        end

      rescue Shutwork::AuthError
        $stderr.puts "Invalid token: #{@token}"
        exit 1
      end

      def verify_token!
        @client = Shutwork::Client.new token: @token, verbose: @verbose
        @client.me
      end
    end
  end
end
