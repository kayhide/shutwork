require "faraday"
require "json"

module Shutwork
  class Client
    attr_reader :base_url

    def initialize opts = {}
      @base_url = opts[:base_url] || "https://api.chatwork.com/v2/"
      @token = opts[:token]
      @conn = Faraday.new(
        url: @base_url,
        headers: {
          "X-ChatWorkToken" => @token
        }
      )
    end

    def me
      @conn.get("me").body
    end

    def rooms
      @conn.get("rooms").body
    end
  end
end
