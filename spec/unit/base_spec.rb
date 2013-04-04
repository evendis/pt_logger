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
      context "when successfully logged" do
        before do
          logger_class.any_instance.should_receive(:send_story_note!).with(expected_message,expected_story_id).and_return(nil)
        end
        it { should be_true }
      end
    end
    context "when story_id is not defined" do
      let(:message) { "test message without ID" }
      it { should be_false }
      it "should not call send_story_note!" do
        logger_class.any_instance.should_receive(:send_story_note!).never
        subject
      end
    end
    context "when some kind of logging error occurs" do
      let(:message) { "test message without ID" }
      before do
        logger_class.any_instance.should_receive(:append_story_note).and_raise(StandardError)
      end
      it { should be_false }
    end
  end

end