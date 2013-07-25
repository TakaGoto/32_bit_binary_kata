class Binary32
  def self.get_sign(number)
    return '1' if number < 0
    '0'
  end

  def self.integer_to_binary(number)
    number.floor.to_s(2)
  end

  def self.fraction_to_binary(number)
    precision_limit = 23 - integer_to_binary(number).to_i.size
    number -= number.floor
    binary_fraction = '.'

    until((number % 1).zero? || binary_fraction.size == precision_limit)
      number *= 2
      binary_fraction += number.floor.to_s
      number -= number.floor
    end

    binary_fraction
  end

  def self.float_number_to_binary(number)
    integer_to_binary(number) + fraction_to_binary(number)
  end

  def self.normalized_exponent(binary)
    Math.log10(binary.to_f).floor
  end

  def self.mantissa(binary)
    binary[0] = ''
    binary.gsub!(/\./, '')
    mantissa = binary + ('0' * (23 - binary.length))
    mantissa
  end

  def self.exponent_to_binary(number)
    (number + 127).to_s(2)
  end

  def self.convert_float_to_binary(number)
    binary_fraction = float_number_to_binary(number)
    get_sign(number) + '-' + exponent_to_binary(normalized_exponent(binary_fraction)) + '-' + mantissa(binary_fraction)
  end
end
