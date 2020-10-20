module Stylers
  class Bold
    def matches?(input)
      input.match?(/\*\*(.*?)\*\*/)
    end

    def to_html(input)
      input.gsub(/\*\*(.*?)\*\*/, '<b>\1</b>')
    end
  end
end
