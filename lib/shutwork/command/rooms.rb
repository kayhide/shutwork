require "json"
require "optparse"

require "shutwork/client"
require "shutwork/command/base"
require "shutwork/token"

module Shutwork
  module Command
    class Rooms < Base
      def parse_args args
        opts = OptionParser.new
        opts.program_name = "shutwork #{self.class.name.split(/::/).last.downcase}"
        opts.on("-r", "--raw", "Show results in raw format") { @raw = true }
        opts.on("-v", "--verbose", "Verbose") { @verbose = true }
        opts.on("--members", "Fetch members instead of messages") { @target = :members }
        opts.on("--files", "Fetch files instead of messages") { @target = :files }
        opts.on("--download", "Download files") { @download = true }
        opts.on("--download-dir DIR", "Set download dir (default: download)") { |dir| @download_dir = dir }
        opts.parse args
      end

      def run args = []
        @args = parse_args args
        token = Shutwork::Token.read
        @client = Shutwork::Client.new token: token, verbose: @verbose

        if @args.first
          if @download
            download @args.first
          else
            show @args.first
          end
        else
          list
        end
      end

      def list
        items = @client.rooms
        if @raw
          puts items
        else
          JSON.parse(items).each(&method(:display_room))
        end
      end

      def show room_id
        items =
          case @target
          when :members
            @display = :display_account
            @client.room_members room_id
          when :files
            @display = :display_file
            @client.room_files room_id
          else
            @display = :display_message
            @client.room_messages room_id
          end
        if @raw
          puts items
        else
          JSON.parse(items).each(&method(@display))
        end
      end

      def download room_id
        dir = Pathname.new(@download_dir || "download").join(room_id.to_s)
        items = @client.room_files room_id
        files = JSON.parse(items)
        files.each do |file|
          dst = dir.join file["filename"]
          if dst.exist?
            say_status "exist", dst, :cyan
          else
            say_status "download", dst, :yellow
            x = @client.file room_id, file["file_id"]
            url = JSON.parse(x)["download_url"]
            at = Time.at file["upload_time"]
            download_file url, dst, at
          end
        end
      end
    end
  end
end
