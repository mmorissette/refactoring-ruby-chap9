class Header
  attr_reader :markdown, :level

  def initialize(markdown:, level:)
    @markdown = markdown
    @level = level
  end

  def matches?(line)
    line.start_with?("#{'#'*level} ")
  end

  def to_html(line)
    title = /#{'\#'*level} (.*)/.match(line).captures[0]
    "<h#{level}>#{markdown.apply_styling(title)}</h#{level}>"
  end
end
