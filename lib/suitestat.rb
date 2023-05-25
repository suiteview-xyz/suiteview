# SuiteStat is a DTO for passing info used to create metrics
class SuiteStat
  attr_accessor :total_count, :output, :tag_counts

  def initialize(output = nil, total_count = 0, tag_counts = {})
    self.output = output
    self.total_count = total_count
    self.tag_counts = tag_counts
  end
end