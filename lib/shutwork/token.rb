require "pathname"

module Shutwork
  module Token
    extend self

    def read
      from_env || from_user_default
    end

    def from_env
      ENV.fetch("CHATWORK_ACCESS_TOKEN", nil)
    end

    def from_user_default
      from_store "default"
    end

    def from_store name
      file = token_path name
      if File.exist? file
        open(file, &:read)
      end
    end

    def store token, name = "default"
      file = token_path name
      FileUtils.mkdir_p file.dirname
      open(file, 'w') do |io|
        io << token.strip
      end
    end

    def storage_dir
      Pathname.new("~/.shutwork/token").expand_path
    end

    def token_path name = "default"
      storage_dir.join name
    end
  end
end
