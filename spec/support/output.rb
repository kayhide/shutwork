Module.new do
  def suppress_stdout
    before do
      allow($stdout).to receive(:puts)
    end
  end

  RSpec.configure do |config|
    config.extend self
  end
end
