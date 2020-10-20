require_relative '../user'

module Stylers
  class ReplaceUsername
    def matches?(input)
      input.match?(/@\w*/)
    end

    def to_html(input)
      input.split(" ").map do |word|
        if match = /@(\w*)/.match(word)
          username = match.captures[0]
          user = User.find(username)
          result = word.gsub("@#{username}", user.name)
        else
          result = word
        end
      end.join(' ')
    end
  end
end
