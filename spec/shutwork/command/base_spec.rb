require "shutwork/command/base"

RSpec.describe Shutwork::Command::Base do
  suppress_stdout

  describe "#to_filesize_human" do
    it "returns B" do
      expect(subject.to_filesize_human 916).to eq "916B"
    end

    it "increses unit to KB at 917B" do
      expect(subject.to_filesize_human 917).to eq "0.9KB"
    end

    it "keeps subdecimal when less than 10.0" do
      expect(subject.to_filesize_human 9.9 * 1024).to eq "9.9KB"
    end

    it "drops subdecimal when equal or greater than 10.0" do
      expect(subject.to_filesize_human 10.0 * 1024).to eq "10KB"
    end

    it "stays unit at 916KB" do
      expect(subject.to_filesize_human 916 * 1024).to eq "916KB"
    end

    it "increses unit to MB at 917KB" do
      expect(subject.to_filesize_human 917 * 1024).to eq "0.9MB"
    end
  end
end
