require 'binary32_three'

def get_binary(num)
  "%032b" % [num].pack('e').reverse.each_char.inject(0) { |sum,c| sum = (sum << 8) + c.ord }
end

describe Binary32Three do

  it 'returns 32 bit binary for 0.0' do
    binary = get_binary(0.0)
    described_class.should_receive(:sign).and_return(binary[0])
    described_class.should_receive(:exponent).and_return(binary[1..8])
    described_class.should_receive(:mantissa).and_return(binary[9..31])
    described_class.convert(0.0).should == binary
  end

  describe "#mantissa" do
    {
      12.345 => get_binary(12.345),
      1.9999999 => get_binary(1.9999999),
      -2.5521175E38 => get_binary(-2.5521175E38),
      Math::PI => get_binary(Math::PI)
    }.each do |num, binary|
      it "returns mantissa for #{num}" do
        described_class.should_receive(:sign).and_return(binary[0])
        described_class.should_receive(:exponent).and_return(binary[1..8])
        (described_class.convert(num).to_i - binary.to_i).abs.should <= 1
      end

      it "returns exponent for #{num}" do
        described_class.should_receive(:sign).and_return(binary[0])
        described_class.should_receive(:mantissa).and_return(binary[9..31])
        described_class.convert(num).should == binary
      end

      it "returns sign for #{num}" do
        described_class.should_receive(:exponent).and_return(binary[1..8])
        described_class.should_receive(:mantissa).and_return(binary[9..31])
        described_class.convert(num).should == binary
      end
    end
  end
end
