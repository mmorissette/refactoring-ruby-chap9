require_relative 'user'
require_relative 'template'

class Markdown
  attr_reader :source, :replace_usernames

  def initialize(source, replace_usernames: false)
    @source = source
    @replace_usernames = replace_usernames
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
    unless line.empty?
      if line.start_with?("# ")
        title = /\# (.*)/.match(line).captures[0]
        "<h1>#{apply_styling(title)}</h1>"
      elsif line.start_with?("## ")
        title = /\#\# (.*)/.match(line).captures[0]
        "<h2>#{apply_styling(title)}</h2>"
      elsif line.start_with?("### ")
        title = /\#\#\# (.*)/.match(line).captures[0]
        "<h3>#{apply_styling(title)}</h3>"
      else
        "<p>#{apply_styling(line)}</p>"
      end
    end
  end

  def apply_styling(input)
    styled_text = input
    unless styled_text.empty?
      if replace_usernames && styled_text.match?(/@\w*/)
        replaced_usernames = styled_text.split(" ").map do |word|
          if match = /@(\w*)/.match(word)
            username = match.captures[0]
            user = User.find(username)
            result = word.gsub("@#{username}", user.name)
          else
            result = word
          end
        end
        styled_text = replaced_usernames.join(' ')
      end

      if styled_text.match?(/{{.*?}}/)
        replaced_templates = styled_text.split(" ").map do |word|
          if match = /{{(.*)}}/.match(word)
            template_name = match.captures[0]
            template = Template.new(template_name)
            result = word.gsub("\{\{#{template_name}\}\}", template.to_s)
          else
            result = word
          end
        end
        styled_text = replaced_templates.join(' ')
      end

      if styled_text.match?(/\*\*(.*?)\*\*/)
        styled_text = styled_text.gsub(/\*\*(.*?)\*\*/, '<b>\1</b>')
      end

      if styled_text.match?(/\*(.*?)\*/)
        styled_text = styled_text.gsub(/\*(.*?)\*/, '<i>\1</i>')
      end
    end
    styled_text
  end
end
