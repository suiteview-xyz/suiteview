require 'spec_helper'

describe SuiteRender do
  let(:repo) { "spec/fixtures/tweeter" }
  describe "csv output" do
    it "can return percentages as csv" do
      @suiteview = SuiteView.new({ repo: repo, include_tags: '@tweets,@followers' })
      expect(@suiteview.percentages.to_csv.render).to eq("tag,percent\n@tweets,80.0\n@followers,20.0\n")
    end
  end

  describe "csv output to file" do
    after do
      FileUtils.rm("my.csv")
    end
    it "can output the csvs to files" do
      @suiteview = SuiteView.new({ repo: repo, include_tags: '@tweets,@followers' })
      @suiteview.percentages.to_csv.render_to_file("my.csv")
      expect(File.readlines("my.csv").join).to eq("tag,percent\n@tweets,80.0\n@followers,20.0\n")
    end
  end
end