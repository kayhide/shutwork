require "shutwork/command/me"

RSpec.describe Shutwork::Command::Me do
  describe "#run" do
    it "calls Client#me" do
      expect_any_instance_of(Shutwork::Client).to receive(:me)
      subject.run
    end
  end
end
