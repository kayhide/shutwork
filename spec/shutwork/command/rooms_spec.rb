require "shutwork/command/rooms"

RSpec.describe Shutwork::Command::Rooms do
  suppress_stdout

  describe "#run" do
    let(:rooms) {
      (1..3).map do |i|
        {
          "room_id" => i,
          "name" => "Room #{i}"
        }
      end.to_json
    }

    before do
      allow_any_instance_of(Shutwork::Client).to receive(:rooms) { rooms }
    end

    it "calls Client#rooms" do
      expect_any_instance_of(Shutwork::Client).to receive(:rooms) { rooms }
      subject.run
    end

    it "outputs rooms" do
      expect {
        subject.run
      }.to output(<<EOS).to_stdout
         1  Room 1
         2  Room 2
         3  Room 3
EOS
    end
  end
end
