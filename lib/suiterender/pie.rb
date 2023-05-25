require 'csv'
require 'chartkick'
require 'launchy'

# The SuiteRender::Pie module makes an html Pie chart
class SuiteRender
  module Pie
    include Chartkick::Helper
    def render_pie_chart_html(filename)
      @filename = filename
      html = pie_chart_html

      File.open(filename, 'w') do |file|
        file.puts html
      end
      self
    end

    def launch
      Launchy.open(File.expand_path(@filename))
    end

  end

  private

   def pie_chart_html
    csv_string = self.view.output
    data = {}
    CSV.parse(csv_string, headers: true) do |row|
      data[row['tag']] = row['count'].to_i
    end

    # Group the data by category and calculate the sum of values for each category
    grouped_data = data.group_by { |k, v| k }
                       .transform_values { |v| v.map(&:last).reduce(:+) }

    pie_chart = pie_chart(grouped_data)


    # Return the HTML code for the pie chart
    <<~HTML
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
            #{pie_chart}
          </body>
        </html>
    HTML
  end
end