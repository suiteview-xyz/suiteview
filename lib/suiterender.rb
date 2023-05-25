require 'csv'
# SuiteRender is responsible for rendering the output of SuiteView
class SuiteRender
  attr_accessor :next_step, :view

  def initialize(suiteview)
    self.next_step = nil
    self.view = suiteview
  end

  def to_csv
    self.view.output = CSV.generate do |csv|
      self.view.output.each { |row| csv << row }
    end
    self
  end

  def render_to_file(filename)
    File.open(filename, "w") do |file|
      file.puts self.view.output
    end
  end

  def render
    self.view.output
  end

  def next_step=(step)
    @next_step = step
  end
end