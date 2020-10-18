class Markdown
  attr_reader :source

  def initialize(source)
    @source = source
  end

  def to_html
    parse
  end

  private

  def parse
    lines.map do |line|
      parse_line(line)
    end.join("\n")
  end

  def lines
    source.split("\n")
  end

  def parse_line(line)
    if line.start_with?("# ")
      title = /\# (.*)/.match(line).captures[0]
      "<h1>#{title}</h1>"
    elsif line.start_with?("## ")
      title = /\#\# (.*)/.match(line).captures[0]
      "<h2>#{title}</h2>"
    elsif line.start_with?("### ")
      title = /\#\#\# (.*)/.match(line).captures[0]
      "<h3>#{title}</h3>"
    else
      "<p>#{line}</p>" unless line.empty?
    end
  end
end
