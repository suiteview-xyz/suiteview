class SuiteView
  attr_accessor :repo
  def initialize(opts)
    self.repo = opts[:repo]
  end
end