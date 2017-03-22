class LCD
  attr_accessor :data

  def initialize(rows=6, cols=50)
    @data = Array.new(rows) {Array.new(cols, false)}
  end

  #Sets rectangle col x row size.
  def rect(col, row)
    row.times do |row_index|
      col.times do |col_index|
        @data[row_index][col_index] = true
      end
    end
  end

  def to_s
    s = ""

    @data.each do |row|
      row.each do |col|
        s << render_value(col)
      end

      s << "\n"
    end

    return s
  end

  def render_value(val)
    val ? '#' : '.'
  end

end

def main()
  lcd = LCD.new
  lcd.rect(3,2)
  puts lcd

  while (input = gets.chomp) != ''
    method, args = parse_input(input)
  end
end

def parse_input(input)

end


main()
