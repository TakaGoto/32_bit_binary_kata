require 'binary32_two'

def get_binary(num)
  "%032b" % [num].pack('e').reverse.each_char.inject(0) { |sum,c| sum = (sum << 8) + c.ord }
end

describe Binary32Two do
  describe "#sign" do
    {
      0.0       => {sign: '0', value: '0' * 8,
                    mantissa: '0' * 23},
      123.456   => {sign: '0', value: '10000101',
                    mantissa: '11101101110100101111001'},
      Math::PI  => {sign: '0', value: '10000000',
                    mantissa: '10010010000111111011011'}
    }.each do |num, binary|
      it "returns #{binary[:sign]} for #{num}" do
        described_class.sign(num).should == binary[:sign]
      end

      it "returns #{binary[:value]} for #{num}" do
        described_class.binary_value(num).should == binary[:value]
      end

      it "returns #{binary[:mantissa]} for #{num}" do
        described_class.mantissa(num).should == binary[:mantissa]
      end
    end
  end
end
