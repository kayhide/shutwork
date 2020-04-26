require "shutwork/command/me"

RSpec.describe Shutwork::Command::Me do
  suppress_stdout

  describe "#run" do
    let(:me) {
      {
        "account_id" => 1,
        "name" => "User 1"
      }
    }

    before do
      allow_any_instance_of(Shutwork::Client).to receive(:me) { me }
    end

    it "calls Client#me" do
      expect_any_instance_of(Shutwork::Client).to receive(:me) { me }
      subject.run
    end

    it "outputs me" do
      expect {
        subject.run
      }.to output(<<EOS).to_stdout
         1  User 1
EOS
    end


  end
end
