class Template
  attr_reader :name, :current_date

  def initialize(name)
    @name = name
    @current_date = Time.now
  end

  def to_s
    return if name.empty?

    if name == "season"
      return season
    elsif name == "today"
      return today
    end
  end

  private

  def today
    current_date.strftime("%Y-%m-%d")
  end

  def season
    if winter?
      "winter ⛄️"
    elsif spring?
      "spring 🌼"
    elsif summer?
      "summer 🌞"
    elsif fall?
      "fall 🍂"
    end
  end

  def winter?
    current_date.between?(Time.new(current_date.year, 12, 21), Time.new(current_date.year, 12, 31)) ||
    current_date.between?(Time.new(current_date.year, 1, 1), Time.new(current_date.year, 3, 19))
  end

  def summer?
    current_date.between?(Time.new(current_date.year, 6, 20), Time.new(current_date.year, 9, 21))
  end

  def spring?()
    current_date.between?(Time.new(current_date.year, 3, 20), Time.new(current_date.year, 6, 19))
  end

  def fall?
    current_date.between?(Time.new(current_date.year, 9, 22), Time.new(current_date.year, 12, 20))
  end
end
