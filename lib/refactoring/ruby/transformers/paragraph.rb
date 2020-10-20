class Paragraph
  def matches?(line)
    true
  end

  def to_html(line)
    "<p>#{line}</p>"
  end
end
