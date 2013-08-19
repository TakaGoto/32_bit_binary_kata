class Binary32Converter
  ExponentBias = 127
  attr_reader :num

  def initialize(num)
    @num = num
  end

  def sign
    @num < 0 ? "1" : "0"
  end

  def exponent
    return "0" * 8 if @num.zero?
    integer_binary = @num.floor.to_s(2)
    exponent = Math.log10(integer_binary.to_i.abs).floor
    exponent = (ExponentBias + exponent).to_s(2)
    exponent.insert(0, '0') if exponent.size == 7
    exponent
  end

  def mantissa
    return "0" * 23 if @num.zero?
    mantissa = (@num.abs * (2 ** 23)).floor.to_s(2)[0..23]
    mantissa[0] = ''
    mantissa
  end

  def binary
    sign + exponent + mantissa
  end
end
