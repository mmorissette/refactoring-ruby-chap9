class MissingUser
  def name
    "unknown"
  end
end

class User
  attr_reader :username, :name

  def initialize(username:, name:)
    @username = username
    @name = name
  end

  USERS = [
    User.new(username: "mmorissette", name: "Martin Morissette")
  ]

  def self.find(username)
    return if username.empty?

    USERS.each do |user|
      return user if user.username == username
    end
    MissingUser.new
  end
end
