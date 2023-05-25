require 'spec_helper'

describe SuiteRender::Pie do
  let(:repo) { "spec/fixtures/tweeter" }
  describe "charting" do
    after do
      FileUtils.rm("#{__dir__}/my_pie.html")
    end
    it "can make a pie chart" do
      @suiteview = SuiteView.new({ repo: repo, include_tags: '@tweets,@followers' }).total_tags_count.to_csv.render_pie_chart_html("#{__dir__}/my_pie.html").launch
      expected_file_contents = <<~FILECONTENTS
        <!DOCTYPE html>
        <html>
          <head>
            <title>Pie Chart</title>
            <script src="https://code.highcharts.com/highcharts.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/chartkick@5.0.1"></script>
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.css">
          </head>
          <body>
            <div id="pie-chart" style="height: 300px;"></div>
            <div id="chart-1" style="height: 300px; width: 100%; text-align: center; color: #999; line-height: 300px; font-size: 14px; font-family: 'Lucida Grande', 'Lucida Sans Unicode', Verdana, Arial, Helvetica, sans-serif;">Loading...</div><script type="text/javascript">
          new Chartkick.PieChart("chart-1", {"@tweets":4,"@followers":1}, {});
        </script>
        
          </body>
        </html>
      FILECONTENTS
      expect(File.readlines("#{__dir__}/my_pie.html").join).to eq expected_file_contents
    end
  end
end