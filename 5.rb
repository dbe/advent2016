require 'digest'

def main()
  prefix = 'abbhdwsy'
  #prefix = "abc"

  i = 0
  password = "zzzzzzzz"

  while true
    if(i % 1000000 == 0)
      puts "Iteration: #{i}"
    end

    input = "#{prefix}#{i}" 
    hash_value = Digest::MD5.hexdigest(input)

    if(interesting_hash(hash_value))
      password_char = extract_password_char(hash_value)
      password_location = extract_password_location(hash_value)

      if(valid_location?(password_location, password))
         password[password_location.to_i] = password_char
         puts "Found valid password character. Password is now: #{password}"
      end

      break if !password.include?('z')
    end

    i+=1
  end

  puts "Answer: #{password}"
end

def interesting_hash(h)
  return h[0..4] == "00000"
end

def extract_password_char(h)
  return h[6]
end

def extract_password_location(h)
  return h[5]
end

def valid_location?(loc, pw)
  return ['0','1','2','3','4','5','6','7'].include?(loc) && pw[loc.to_i] == 'z'
end

main()
