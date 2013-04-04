require 'spec_helper'

describe PtLogger do
  let(:resource_class) { PtLogger }
  let(:logger_class) { PtLogger::Logger }

  describe "##log" do
    subject { resource_class.log(message) }
    context "when story_id is defined in the message" do
      let(:expected_story_id) { 12345678 }
      let(:message) { "test message for story ##{expected_story_id}" }
      let(:expected_message) { "[PtLogger] #{message}" }
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

  describe "#log_if" do

    context "with implicit story ID" do
      let(:expected_story_id) { 12345678 }
      let(:message) { "test message for story ##{expected_story_id}" }
      let(:expected_message) { "[PtLogger] #{message}" }

      context "when message passed as block" do
        subject { resource_class.log_if(condition) do
          message
        end }
        context "when successfully logged" do
          let(:condition) { true }
          before do
            logger_class.any_instance.should_receive(:send_story_note!).with(expected_message,expected_story_id).and_return(nil)
          end
          it { should be_true }
        end
        context "when log prevented by condition" do
          let(:condition) { false }
          before do
            logger_class.any_instance.should_receive(:send_story_note!).never
          end
          it { should be_false }
        end
      end

      context "when message passed as parameter" do
        subject { resource_class.log_if(condition,message) }
        context "when successfully logged" do
          let(:condition) { true }
          before do
            logger_class.any_instance.should_receive(:send_story_note!).with(expected_message,expected_story_id).and_return(nil)
          end
          it { should be_true }
        end
        context "when log prevented by condition" do
          let(:condition) { false }
          before do
            logger_class.any_instance.should_receive(:send_story_note!).never
          end
          it { should be_false }
        end
      end

    end

    context "with explicit story ID" do
      let(:expected_story_id) { 12345678 }
      let(:message) { "test message" }
      let(:expected_message) { "[PtLogger] #{message}" }

      context "when message passed as block" do
        subject { resource_class.log_if(condition,expected_story_id) do
          message
        end }
        context "when successfully logged" do
          let(:condition) { true }
          before do
            logger_class.any_instance.should_receive(:send_story_note!).with(expected_message,expected_story_id).and_return(nil)
          end
          it { should be_true }
        end
        context "when log prevented by condition" do
          let(:condition) { false }
          before do
            logger_class.any_instance.should_receive(:send_story_note!).never
          end
          it { should be_false }
        end
      end

      context "when message passed as parameter" do
        subject { resource_class.log_if(condition,message,expected_story_id) }
        context "when successfully logged" do
          let(:condition) { true }
          before do
            logger_class.any_instance.should_receive(:send_story_note!).with(expected_message,expected_story_id).and_return(nil)
          end
          it { should be_true }
        end
        context "when log prevented by condition" do
          let(:condition) { false }
          before do
            logger_class.any_instance.should_receive(:send_story_note!).never
          end
          it { should be_false }
        end
      end

    end

  end

end