require "shutwork/client"
require "shutwork/token"

RSpec.describe Shutwork::Client do
  subject { described_class.new token: token }
  let(:token) { Shutwork::Token.read }

  describe "#me" do
    it "returns account" do
      VCR.use_cassette "client/me" do
        res = subject.me
        item = JSON.parse(res)
        expect(item).to include(*%w(account_id name))
      end
    end
  end

  describe "#rooms" do
    it "returns list of rooms" do
      VCR.use_cassette "client/rooms" do
        res = subject.rooms
        items = JSON.parse(res)
        expect(items.length).to eq 3
        expect(items).to all include(*%w(room_id name))
      end
    end
  end

  describe "#room_messages" do
    it "returns list of messages" do
      VCR.use_cassette "client/room_messages" do
        res = subject.room_messages 1
        items = JSON.parse(res)
        expect(items.length).to eq 4
        expect(items).to all include(*%w(message_id body))
        expect(items).to all include("account" => include(*%w(name)))
      end
    end
  end

  describe "#room_members" do
    it "returns list of members" do
      VCR.use_cassette "client/room_members" do
        res = subject.room_members 1
        items = JSON.parse(res)
        expect(items.length).to eq 3
        expect(items).to all include(*%w(account_id name))
      end
    end
  end

  describe "#room_files" do
    it "returns list of files" do
      VCR.use_cassette "client/room_files" do
        res = subject.room_files 1
        items = JSON.parse(res)
        expect(items.length).to eq 4
        expect(items).to all include(*%w(filename filesize upload_time))
      end
    end
  end

  context "without authorized" do
    let(:token) { "token-not-authorized" }

    it "raises an error" do
      VCR.use_cassette "client/me--unauthorized" do
        expect {
          subject.me
        }.to raise_error(Shutwork::AuthError)
      end
    end
  end
end
