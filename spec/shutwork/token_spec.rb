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

  describe ".from_user_default" do
    use_tmp_dir
    subject { described_class }
    let(:token_file) { tmp_dir.join "token/default" }

    it "calls .from_store with 'default'" do
      expect(subject).to receive(:from_store).with("default")
      subject.from_user_default
    end
  end

  describe ".from_store" do
    use_tmp_dir
    subject { described_class }
    let(:token_file) { tmp_dir.join "token/default" }

    before do
      allow(Shutwork::Token).to receive(:storage_dir) { token_file.dirname }
      FileUtils.mkdir_p token_file.dirname
      open(token_file, 'w') { |io| io << "bien" }
    end

    it "reads from user default" do
      expect(subject.from_store("default")).to eq "bien"
    end
  end

  describe ".store" do
    use_tmp_dir
    subject { described_class }
    let(:token_file) { tmp_dir.join "token/default" }

    before do
      allow(Shutwork::Token).to receive(:storage_dir) { token_file.dirname }
      FileUtils.mkdir_p token_file.dirname
    end

    it "stores given token" do
      expect {
        Shutwork::Token.store "yoroshi"
      }.to change { Shutwork::Token.from_user_default }.from(nil).to("yoroshi")
    end
  end
end
