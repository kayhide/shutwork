require "shutwork/client"
require "shutwork/token"

RSpec.describe Shutwork::Client do
  describe "#me" do
    subject { described_class.new token: token }
    let(:token) { Shutwork::Token.read }

    it "returns me" do
      res = subject.me
      expect(res).not_to be nil
    end
  end
end
