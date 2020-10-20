class Header
  attr_reader :level

  def initialize(level:)
    @level = level
  end

  def matches?(line)
    line.start_with?("#{'#'*level} ")
  end

  def to_html(line)
    title = /#{'\#'*level} (.*)/.match(line).captures[0]
    "<h#{level}>#{title}</h#{level}>"
  end
end
