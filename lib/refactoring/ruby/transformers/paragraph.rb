class Paragraph
  attr_reader :markdown

  def initialize(markdown:)
    @markdown = markdown
  end

  def matches?(line)
    true
  end

  def to_html(line)
    "<p>#{markdown.apply_styling(line)}</p>"
  end
end
