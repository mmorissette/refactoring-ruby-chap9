class Template
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    result = ""
    unless name.empty?
      current_date = Time.now
      if name == "season" && current_date.between?(Time.new(current_date.year, 12, 21), Time.new(current_date.year, 12, 31)) || current_date.between?(Time.new(current_date.year, 1, 1), Time.new(current_date.year, 3, 19))
        result = "winter ⛄️"
      elsif name == "season" && current_date.between?(Time.new(current_date.year, 3, 20), Time.new(current_date.year, 6, 19))
        result "spring 🌼"
      elsif name == "season" && current_date.between?(Time.new(current_date.year, 6, 20), Time.new(current_date.year, 9, 21))
        result = "summer 🌞"
      elsif name == "season" && current_date.between?(Time.new(current_date.year, 9, 22), Time.new(current_date.year, 12, 20))
        result = "fall 🍂"
      elsif name == "today"
        result = current_date.strftime("%Y-%m-%d")
      end
    end
    result
  end
end
