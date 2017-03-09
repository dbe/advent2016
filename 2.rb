NUMPAD = [
  [nil, nil, 1, nil, nil],
  [nil, 2, 3, 4, nil],
  [5, 6, 7, 8, 9],
  [nil, 'A', 'B', 'C', nil],
  [nil, nil, 'D', nil, nil]
]

def valid_coords(row, col)
  return valid_row(row) && valid_col(col) && NUMPAD[row][col] != nil
end

def valid_row(row)
  return row >= 0 && row < NUMPAD.length
end

def valid_col(col)
  return col >= 0 && col < NUMPAD[0].length
end

def calc_digit(input, row, col)
  for i in 0..input.length - 1
    case input[i]
    when "U"
      if valid_coords(row - 1, col)
        row -= 1
      end
    when "D"
      if valid_coords(row + 1, col)
        row += 1
      end
    when "L"
      if valid_coords(row, col - 1)
        col -= 1
      end
    when "R"
      if valid_coords(row, col + 1)
        col += 1
      end
    end
  end

  digit = NUMPAD[row][col]

  return digit, row, col
end


code = []
row = 2
col = 0


while (input = gets.chomp) != ''
  digit, row, col = calc_digit(input, row, col)
  code << digit
end


puts "Code: #{code}"
