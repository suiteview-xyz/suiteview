require 'spec_helper'

describe SuiteView do
  # Tests specific to the `tweeter` use case
  context "tweeter" do
    let(:repo) { "fixtures/tweeter" }
    before do
      @suiteview = SuiteView.new({repo: repo})
    end

    describe "tag counts for scenario outlines" do
      expect(@suiteview.outline_tag_count("@tweets")).to eq 3
    end
  end
end