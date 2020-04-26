require "faraday"
require "json"

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
      res = @conn.get("me")
      if @verbose
        $stderr.puts res.headers.to_json
      end
      res.body
    end

    def rooms
      res = @conn.get("rooms")
      if @verbose
        $stderr.puts res.headers.to_json
      end
      res.body
    end

    def room_messages room_id
      res = @conn.get("rooms/#{room_id}/messages?force=1")
      if @verbose
        $stderr.puts res.headers.to_json
      end
      res.body
    end
  end
end
