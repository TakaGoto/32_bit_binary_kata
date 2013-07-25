class Binary32Two
  ExponentBiased = 127

  def self.sign(num)
    return '1' if num < 0
    '0'
  end

  def self.binary_value(num)
    return '0' * 8 if num.zero?
    integer_binary = num.floor.to_s(2).to_i
    exponent = Math.log10(integer_binary).floor
    binary_value = (exponent + ExponentBiased).to_s(2)
    binary_value
  end

  def self.mantissa(num)
    return '0' * 23 if num.zero?
    integer_binary = num.floor.to_s(2)
    precision_limit = 23 - integer_binary.to_i.size
    num -= num.floor
    fraction_binary = '.'

    until((num % 1).zero? || fraction_binary.size == precision_limit)
      num *= 2
      fraction_binary += num.floor.to_s
      num -= num.floor
    end

    puts "#{fraction_binary} before"
    fraction_binary.gsub!(/\./, '')
    fraction_binary[0] = ''
    puts "#{fraction_binary} after"

    return integer_binary + fraction_binary
  end
end
