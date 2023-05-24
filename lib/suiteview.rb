require 'cql'
require 'csv'
class SuiteView
  attr_accessor :repo, :include_tags, :output
  def initialize(opts)
    self.output = nil
    self.repo = CQL::Repository.new(opts[:repo])
    self.include_tags = opts[:include_tags]
  end

  def outline_tag_count(tag)
    self.output = self.repo.query do
      select examples
      transform examples => lambda {|examples| examples[0].rows.drop(1) }
      from outlines
      with { |outline| outline.tags.map(&:name).include?(tag)}
    end.map {|item| item['examples']}.flatten.count
    self
  end

  def scenario_tag_count(tag)
    self.output = self.repo.query do
      select name
      from scenarios
      with { |scenario| scenario.tags.map(&:name).include?(tag)}
    end.map {|item| item['name']}.count
    self
  end

  def total_tag_count(tag)
    self.output = scenario_tag_count(tag).render + outline_tag_count(tag).render
    self
  end

  def percentages
    output = [%w(tag percent)]
    total_count = 0
    tag_counts = {}
    self.include_tags.split(',').each do |include_tag|
      total_count += total_tag_count(include_tag).render
      tag_counts[include_tag] = total_tag_count(include_tag).render
    end
    self.include_tags.split(',').each do |include_tag|
      output << [include_tag, ((tag_counts[include_tag]/total_count.to_f)*100).to_s]
    end
    self.output = output
    self
  end

  def to_csv
    self.output = CSV.generate do |csv|
      self.output.each do |row|
        csv << row
      end
    end
    self
  end

  def render
    self.output
  end

  def render_to_file(filename)
    File.open(filename, "w") do |f|
      f.puts self.output
    end
  end
end