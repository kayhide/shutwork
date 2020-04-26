require "shutwork/command/rooms"

RSpec.describe Shutwork::Command::Rooms do
  describe "#run" do
    it "calls Client#rooms" do
      expect_any_instance_of(Shutwork::Client).to receive(:rooms)
      subject.run
    end
  end
end
