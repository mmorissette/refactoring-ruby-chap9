module Stylers
  class Italics
    def matches?(input)
      input.match?(/\*(.*?)\*/)
    end

    def to_html(input)
      input.gsub(/\*(.*?)\*/, '<i>\1</i>')
    end
  end
end
