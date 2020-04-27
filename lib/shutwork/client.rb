require "faraday"
require "json"

require "shutwork"

module Shutwork
  class Client
    attr_reader :base_url

    def initialize opts = {}
      @base_url = opts[:base_url] || "https://api.chatwork.com/v2/"
      @token = opts[:token]
      @verbose = opts[:verbose]
      @conn = Faraday.new(
        url: @base_url,
        headers: {
          "X-ChatWorkToken" => @token
        }
      )
    end

    def me
      process @conn.get("me")
    end

    def rooms
      process @conn.get("rooms")
    end

    def room_messages room_id
      process @conn.get("rooms/#{room_id}/messages?force=1")
    end

    def room_members room_id
      process @conn.get("rooms/#{room_id}/members")
    end

    def room_files room_id
      process @conn.get("rooms/#{room_id}/files")
    end

    def file room_id, file_id
      process @conn.get("rooms/#{room_id}/files/#{file_id}?create_download_url=1")
    end

    def process res
      if @verbose
        $stderr.puts res.headers.to_json
      end
      verify! res
      res.body
    end

    def verify! res
      if res.status.to_s !~ /2../
        raise Shutwork::AuthError.new(res.body)
      end
    end
  end
end
