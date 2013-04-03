require 'spec_helper'

describe PtLogger do
  let(:resource_class) { PtLogger }

  before do
    set_test_credentials
  end

  context "with embedded story id", :vcr do
    let(:message) { "a test message for the PT:#{test_story_id} story" }
    subject { resource_class.log(message) }
    it "logs successfully" do
      should be_a(PivotalTracker::Note)
    end
  end

end