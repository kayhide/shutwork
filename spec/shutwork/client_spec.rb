require "shutwork/client"
require "shutwork/token"

RSpec.describe Shutwork::Client do
  subject { described_class.new token: token }
  let(:token) { Shutwork::Token.read }

  describe "#me" do
    it "returns me" do
      res = subject.me
      expect(res).not_to be nil
    end
  end

  describe "#rooms" do
    it "returns rooms" do
      res = subject.rooms
      expect(res).not_to be nil
    end
  end
end
