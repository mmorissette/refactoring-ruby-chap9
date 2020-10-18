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
    found_user = nil
    unless username.empty?
      found = false
      USERS.each do |user|
        unless found
          if user.username == username
            found_user = user
            found = true
          end
        end
      end
    end
    found_user
  end

end
