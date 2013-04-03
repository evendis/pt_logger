require 'spec_helper'

describe PtLogger do
  let(:resource_class) { PtLogger }
  let(:logger_class) { PtLogger::Logger }

  describe "##log" do
    subject { resource_class.log(message) }
    context "when story_id is defined in the message" do
      let(:message) { "test message for story #12345678" }
      let(:expected_message) { "[PtLogger] test message for story #12345678" }
      let(:expected_story_id) { 12345678 }
      it "should not call send_story_note!" do
        logger_class.any_instance.should_receive(:send_story_note!).with(expected_message,expected_story_id).and_return(nil)
        subject
      end
    end
    context "when story_id is not defined" do
      let(:message) { "test message without ID" }
      it "should not call send_story_note!" do
        logger_class.any_instance.should_receive(:send_story_note!).never
        subject
      end
    end
  end

end