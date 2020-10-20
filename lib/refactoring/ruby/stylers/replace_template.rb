require_relative '../template'

module Stylers
  class ReplaceTemplate
    def matches?(input)
      input.match?(/{{.*?}}/)
    end

    def to_html(input)
      input.split(" ").map do |word|
        if match = /{{(.*)}}/.match(word)
          template_name = match.captures[0]
          template = Template.new(template_name)
          result = word.gsub("\{\{#{template_name}\}\}", template.to_s)
        else
          result = word
        end
      end.join(' ')
    end
  end
end
