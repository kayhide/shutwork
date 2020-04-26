require "pathname"

module Shutwork
  module Token
    extend self

    def read
      from_env || from_user_default
    end

    def from_env
      ENV.fetch("CHATWORK_ACCESS_TOKEN")
    end

    def from_user_default
      from_store "default"
    end

    def from_store name
      file = storage_dir.join name
      if File.exist? file
        open(file, &:read)
      end
    end

    def store token, name = "default"
      file = storage_dir.join name
      open(file, 'w') do |io|
        io << token.strip
      end
    end

    def storage_dir
      Pathname.new("~/.shutwork/token").expand_path
    end
  end
end
