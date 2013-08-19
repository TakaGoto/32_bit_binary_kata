require 'binary32'

def get_binary(num)
  [num].pack('g').bytes.map{|n| "%08b" % n}.join
  #=> [123.456]
  #=> #pack "four character 32 bit"
  #=> #bytes "an array of the ordinal of the char"
  #=> #map "08b" % a ordinal
  #=> joining array of string together
end

def compare_binary(result, expected)
  (result.to_i(2) - expected.to_i(2)).abs.should <= 1
end

describe Binary32Converter do
  describe "convert floating number to a 32 bit binary" do
    {
      0.0 => get_binary(0.0),
      123.456 => get_binary(123.456),
      Math::PI => get_binary(Math::PI),
      1.9999999 => get_binary(1.9999999),
      -2.231424E22 => get_binary(-2.231424E22)
    }.each do |num, binary|
      converter = described_class.new(num)

      it "returns the first bit (sign) for #{num}" do
        converter.sign.should == binary[0]
      end

      it "returns 8 bits (exponent) after sign for #{num}" do
        converter.exponent.should == binary[1..8]
      end

      it "returns 23 bits (mantissa) after sign and exponent for #{num}" do
        result = converter.mantissa
        compare_binary(result, binary[9..31])
      end

      it "returns the 32 bit binary for #{num}" do
        result = converter.binary
        compare_binary(result, binary)
      end
    end
  end
end
