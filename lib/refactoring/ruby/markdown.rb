require_relative 'user'
require_relative 'template'
require_relative 'transformers/header'
require_relative 'transformers/paragraph'
require_relative 'stylers/bold'
require_relative 'stylers/italics'
require_relative 'stylers/replace_username'
require_relative 'stylers/replace_template'

class Markdown
  attr_reader :source, :replace_usernames, :transformers, :stylers

  def initialize(source, replace_usernames: false)
    @source = source
    @replace_usernames = replace_usernames
    @transformers = [
      Header.new(markdown: self, level: 1),
      Header.new(markdown: self, level: 2),
      Header.new(markdown: self, level: 3),
      Paragraph.new(markdown: self)
    ]

    @stylers = [
      ::Stylers::Bold.new,
      ::Stylers::Italics.new,
      ::Stylers::ReplaceTemplate.new,
    ]
    stylers << ::Stylers::ReplaceUsername.new if replace_usernames
  end

  def to_html
    parse
  end

  def apply_styling(input)
    styled_text = input
    return if styled_text.empty?

    stylers.each do |styler|
      if styler.matches?(styled_text)
        styled_text = styler.to_html(styled_text)
      end
    end

    styled_text
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
    return if line.empty?

    transformer = transformers.find { |t| t.matches?(line) }
    transformer.to_html(line)
  end
end
