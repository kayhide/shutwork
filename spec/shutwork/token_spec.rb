require "tmpdir"

require "shutwork/token"

RSpec.describe Shutwork::Token do
  describe ".from_env" do
    subject { described_class }

    before do
      allow(ENV).to receive(:fetch).with("CHATWORK_ACCESS_TOKEN") {
        "good"
      }
    end

    it "reads env" do
      expect(subject.from_env).to eq "good"
    end
  end

  describe ".from_store" do
    subject { described_class }

    around do |example|
      Dir.mktmpdir("shutwork-test-") do |dir|
        @tmp_dir = Pathname.new(dir)
        example.run
      end
    end

    before do
      allow(Shutwork::Token).to receive(:storage_dir) { @tmp_dir }
      open(@tmp_dir.join("default"), 'w') { |io| io << "bien" }
    end

    it "reads from user default" do
      expect(subject.from_store("default")).to eq "bien"
    end
  end

  describe ".store" do
    subject { described_class }

    around do |example|
      Dir.mktmpdir("shutwork-test-") do |dir|
        @tmp_dir = Pathname.new(dir)
        example.run
      end
    end

    before do
      allow(Shutwork::Token).to receive(:storage_dir) { @tmp_dir }
    end

    it "stores given token" do
      expect {
        Shutwork::Token.store "yoroshi"
      }.to change { Shutwork::Token.from_user_default }.from(nil).to("yoroshi")
    end
  end
end
