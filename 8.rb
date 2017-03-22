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

  def on_count
    @data.reduce(0) {|sum, row| sum + row.count(true)}
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

  File.open('8.1.txt', 'r') do |file|
    while !file.eof?
      method, args = parse_input(file.gets.chomp)
      if(method)
        puts "Found method: #{method}"
        puts "args: #{args}"
        lcd.send(method, *args)
      end
    end
  end

  puts lcd
  puts "On count: #{lcd.on_count}"
end

RECT_REGEX = /rect (\d+)x(\d+)/
def parse_input(input)
  if(match = input.match(RECT_REGEX))
    return :rect, [match.captures[0].to_i, match.captures[1].to_i]
  end
end


main()
