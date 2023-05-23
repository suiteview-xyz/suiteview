class SuiteView
  attr_accessor :repo
  def initialize(opts)
    self.repo = CQL::Repository.new(opts[:repo])
  end

  def outline_tag_count(tag)
    self.repo.query do
      select examples
      transform examples => lambda {|examples| examples[0].rows.drop(1) }
      from outlines
      with { || outline.tags.map(&:name).include?(tag)}
    end.map {|item| item['examples']}.flatten.count
  end
end