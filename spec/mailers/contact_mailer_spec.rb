require "spec_helper"

describe ContactMailer do
  describe "get_in_touch" do
    let(:mail) { ContactMailer.get_in_touch }

    it "renders the headers" do
      mail.subject.should eq("Get in touch")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
