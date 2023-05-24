require 'spec_helper'

describe SuiteView do
  # Tests specific to the `tweeter` use case
  context "tweeter" do
    let(:repo) { "spec/fixtures/tweeter" }
    before do
      @suiteview = SuiteView.new({repo: repo})
    end

    describe "tag counts for scenario outlines" do
      it "returns the correct tag count for @tweets in scenario outlines" do
        expect(@suiteview.outline_tag_count("@tweets")).to eq 3
      end
    end

    describe "tag counts for scenarios" do
      it "returns the correct ag count for @tweets in scenarios" do
        expect(@suiteview.scenario_tag_count("@tweets")).to eq 1
      end
    end
  end
end