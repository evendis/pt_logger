require 'spec_helper'

describe PtLogger::Logger do

  let(:resource_class) { PtLogger::Logger }
  let(:instance) { resource_class.new }

  context "when configured" do
    let(:api_key)    { 'somthing' }
    let(:project_id) { 'somthingelse' }

    before do
      PtLogger.setup do |config|
        config.api_key    = api_key
        config.project_id = project_id
      end
    end

    describe "#api_key" do
      subject { instance.api_key }
      it { should_not be_nil }
    end

    describe "#project_id" do
      subject { instance.project_id }
      it { should_not be_nil }
    end

    describe "#project" do
      let(:mock_project) { mock() }
      before do
        PivotalTracker::Project.stub(:find).and_return(mock_project)
      end
      subject { instance.project }
      it { should eql(mock_project) }
    end

  end

  describe "#extract_story_id_from" do
    subject { instance.extract_story_id_from(message) }
    [
      { given: 'contains no story ref', expect: nil},
      { given: 'contains #12 ref', expect: 12},
      { given: 'contains at end of string #123', expect: 123},
      { given: '#1234 contains at start of string', expect: 1234},
      { given: 'contains pt PT:12345 ref', expect: 12345},
      { given: 'contains pt lowercase pt:123456 ref', expect: 123456},
      { given: 'contains #1234embeded ref', expect: nil}
    ].each do |expectations|
      context "when given '#{expectations[:given]}'" do
        let(:message) { expectations[:given] }
        it { should eql(expectations[:expect]) }
      end
    end
  end

  describe "#append_story_note" do
    subject { instance.append_story_note(message) }
    context "when story_id is defined in the message" do
      let(:message) { "test message for story #12345678" }
      let(:expected_message) { "[PtLogger] test message for story #12345678" }
      let(:expected_story_id) { 12345678 }
      it "should not call send_story_note!" do
        instance.should_receive(:send_story_note!).with(expected_message,expected_story_id).and_return(nil)
        subject
      end
    end
    context "when story_id is not defined" do
      let(:message) { "test message without ID" }
      it "should not call send_story_note!" do
        instance.should_receive(:send_story_note!).never
        subject
      end
    end
    context "when story_id is defined explicitly" do
      subject { instance.append_story_note(message,story_id) }
      let(:message) { "test message for story #12345678" }
      let(:story_id) { 87654321 }
      let(:expected_message) { "[PtLogger] test message for story #12345678" }
      let(:expected_story_id) { 87654321 }
      it "should not call send_story_note!" do
        instance.should_receive(:send_story_note!).with(expected_message,expected_story_id).and_return(nil)
        subject
      end
    end
  end


end