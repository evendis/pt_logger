require 'spec_helper'

describe PtLogger do
  let(:resource) { PtLogger }

  ['api_key','project_id'].each do |string_config_option|
    describe "##{string_config_option}" do
      subject { resource.send(string_config_option) }

      let(:expected) { 'somthing' }
      before do
        resource.send("#{string_config_option}=",expected)
      end
      it { should eql(expected) }

    end
  end

  describe "##setup" do
    let(:api_key) { 'somthing' }
    before do
      resource.setup do |config|
        config.api_key = api_key
      end
    end
    subject { resource }
    its(:api_key) { should eql(api_key) }
  end

end