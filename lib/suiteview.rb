require 'cql'
require_relative './suitestat'
require_relative './suiterender/suiterender'
require_relative './suiterender/pie'
# SuiteView is responsible for providing consumable Ruby Cucumber suite stats
class SuiteView
  include SuiteRender::Pie
  attr_accessor :repo, :include_tags, :exclude_tag, :output, :render_step

  def initialize(opts)
    self.output = nil
    self.repo = CQL::Repository.new(opts[:repo])
    self.include_tags = opts[:include_tags] || ""
    self.include_tags = self.include_tags.split(',')
    self.exclude_tag = opts[:exclude_tag]

    # Create a SuiteRender object and set it as the last step in the chain
    self.render_step = SuiteRender.new(self)
    render_step.next_step = self
    self
  end

  def outline_tag_count(tag)
    self.output = outline_query(tag).map { |item| item['examples'] }.flatten.count
    self
  end

  def scenario_tag_count(tag)
    self.output = scenario_query(tag).map { |item| item['name'] }.count
    self
  end

  def total_tag_count(tag)
    self.output = scenario_tag_count(tag).render + outline_tag_count(tag).render
    self
  end

  def total_tags_count
    output = [%w(tag count)]
    self.include_tags.each do |tag|
      output << [tag, total_tag_count(tag).render.to_s]
    end
    self.output = output
    self
  end

  def percentages
    suite_stat_dto = SuiteStat.new([%w(tag percent)], 0, {})
    self.output = calc_percentage(suite_stat_dto)
    self
  end

  def to_csv
    self.render_step.to_csv
  end

  def render
    self.render_step.render
  end

  def render_to_file(filename)
    self.render_step.render_to_file(filename)
  end

  private

  def calc_percentage(suite_stat_dto)
    suite_stat_dto.total_count = calc_percentage_totals(suite_stat_dto)
    collate_percentage_rows(suite_stat_dto)
  end

  def collate_percentage_rows(suite_stat_dto)
    output = suite_stat_dto.output
    self.include_tags.each do |include_tag|
      output << [include_tag, ((suite_stat_dto.tag_counts[include_tag] / suite_stat_dto.total_count.to_f) * 100).to_s]
    end
    output
  end

  def calc_percentage_totals(suite_stat_dto)
    total_count = suite_stat_dto.total_count
    self.include_tags.each do |include_tag|
      count_for_tag = total_tag_count(include_tag)
      total_count += count_for_tag.render
      suite_stat_dto.tag_counts[include_tag] = count_for_tag.render
    end
    total_count
  end

  def outline_query(tag)
    exclude_tag = self.exclude_tag
    self.repo.query do
      select examples
      transform examples => lambda { |examples| examples[0].rows.drop(1) }
      from outlines
      with { |outline| outline.tags.map(&:name).include?(tag) }
      without { |outline| outline.tags.map(&:name).include?(exclude_tag) }
    end
  end

  def scenario_query(tag)
    exclude_tag = self.exclude_tag
    self.repo.query do
      select name
      from scenarios
      with { |scenario| scenario.tags.map(&:name).include?(tag) }
      without { |scenario| scenario.tags.map(&:name).include?(exclude_tag) }
    end
  end
end