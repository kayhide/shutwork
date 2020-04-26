Module.new do
  def use_tmp_dir
    around do |example|
      Dir.mktmpdir("shutwork-test-") do |dir|
        @tmp_dir = Pathname.new(dir)
        example.run
      end
    end

    let(:tmp_dir) { @tmp_dir }
  end

  RSpec.configure do |config|
    config.extend self
  end
end
