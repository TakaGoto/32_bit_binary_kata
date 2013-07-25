class Binary32Three
  ExponentBias = 127

  def self.convert(num)
    @num = num
    sign + exponent + mantissa
  end

  def self.sign
    return '1' if @num < 0
    '0'
  end

  def self.exponent
    integer_binary = @num.floor.to_s(2).to_i
    exponent = Math.log10(integer_binary.abs).floor
    exponent = (ExponentBias + exponent).to_s(2)
    exponent.insert(0, '0') if exponent.size == 7
    exponent
  end

  def self.mantissa
    mantissa = (@num.abs * 2 ** 23).floor.to_s(2)[0..23]
    mantissa[0] = ''
    mantissa
  end
end
