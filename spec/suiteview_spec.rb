require 'spec_helper'

describe SuiteView do
  # Tests specific to the `tweeter` use case
  context "tweeter" do
    let(:repo) { "spec/fixtures/tweeter" }
    before do
      @suiteview = SuiteView.new({repo: repo})
    end

    describe "tag count methods with tags as an argument" do
    describe "tag counts for scenario outlines" do
      it "returns the correct tag count for @tweets in scenario outlines" do
        expect(@suiteview.outline_tag_count("@tweets").render).to eq 3
      end
    end

    describe "tag counts for scenarios" do
      it "returns the correct tag count for @tweets in scenarios" do
        expect(@suiteview.scenario_tag_count("@tweets").render).to eq 1
      end
    end

    describe "total tag counts for both" do
      it "returns the correct total_tag_count for @tweets" do
        expect(@suiteview.total_tag_count("@tweets").render).to eq 4
      end
    end
    end

    describe "tag counts with include_tags option" do
      describe "single tag percentages" do
        it "returns tag percentages for {include_tags: '@tweets'}" do
          @suiteview = SuiteView.new({repo: repo, include_tags: '@tweets'})
          expect(@suiteview.percentages.render).to eq([%w(tag percent),%w(@tweets 100.0)])
        end
      end
      describe "multiple tag percentages" do
        it "returns tag percentages for {include_tags: '@tweets,@followers'}" do
          @suiteview = SuiteView.new({repo: repo, include_tags: '@tweets,@followers'})
          expect(@suiteview.percentages.render).to eq([%w(tag percent),%w(@tweets 80.0),%w(@followers 20.0)])
        end
      end
    end

    describe "csv output" do
      it "can return percentages as csv" do
        @suiteview = SuiteView.new({repo: repo, include_tags: '@tweets,@followers'})
        expect(@suiteview.percentages.to_csv.render).to eq("tag,percent\n@tweets,80.0\n@followers,20.0\n")
      end

    end

    describe "csv output to file" do
      after do
        FileUtils.rm("my.csv")
      end
      it "can output the csvs to files" do
        @suiteview = SuiteView.new({repo: repo, include_tags: '@tweets,@followers'})
        @suiteview.percentages.to_csv.render_to_file("my.csv")
        expect(File.readlines("my.csv").join).to eq("tag,percent\n@tweets,80.0\n@followers,20.0\n")
      end
    end
  end
end