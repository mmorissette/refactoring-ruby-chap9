class Template
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    return if name.empty?

    result = ""
    if name == "season"
      result = season
    elsif name == "today"
      result = today
    end
    result
  end

  private

  def today
    Time.now.strftime("%Y-%m-%d")
  end

  def season
    current_date = Time.now
    if current_date.between?(Time.new(current_date.year, 12, 21), Time.new(current_date.year, 12, 31)) || current_date.between?(Time.new(current_date.year, 1, 1), Time.new(current_date.year, 3, 19))
      result = "winter ⛄️"
    elsif current_date.between?(Time.new(current_date.year, 3, 20), Time.new(current_date.year, 6, 19))
      result "spring 🌼"
    elsif current_date.between?(Time.new(current_date.year, 6, 20), Time.new(current_date.year, 9, 21))
      result = "summer 🌞"
    elsif current_date.between?(Time.new(current_date.year, 9, 22), Time.new(current_date.year, 12, 20))
      result = "fall 🍂"
    end
  end
end
