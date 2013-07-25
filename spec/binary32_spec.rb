require 'binary32'

describe Binary32 do
  describe "#get_sign" do
    it 'gets the binary sign' do
      described_class.get_sign(12.375).should == '0'
    end

    it 'gets the binary sign for a negative number' do
      described_class.get_sign(-12.375).should == '1'
    end
  end

  describe "#integer_to_binary" do
    it 'converts 12.375 to 1100' do
      described_class.integer_to_binary(12.375).should == '1100'
    end

    it 'converts 11.375 to 1011' do
      described_class.integer_to_binary(11.375).should == '1011'
    end

    it 'converts 123.456 to 1111011' do
      described_class.integer_to_binary(123.456).should == '1111011'
    end
  end

  describe "#fraction_to_binary" do
    it 'converts 12.375 to .011' do
      described_class.fraction_to_binary(12.375).should == '.011'
    end

    it 'converts 12.25 to .01' do
      described_class.fraction_to_binary(12.25).should == '.01'
    end
  end

  describe "#float_number_to_binary" do
    it 'converts 12.375 to 1100.011' do
      described_class.float_number_to_binary(12.375).should == '1100.011'
    end

    it 'converts 12.25 to 1100.01' do
      described_class.float_number_to_binary(12.25).should == '1100.01'
    end

    xit 'converts 1.9999999 to' do
      described_class.float_number_to_binary(1.9999999).should == '1100.01'
    end
  end

  describe "normalized_exponent" do
    it 'gets exponent 3 for 1100.011' do
      described_class.normalized_exponent('1100.011').should == 3
    end

    it 'gets exponent 4 for 11000.11' do
      described_class.normalized_exponent('11000.11').should == 4
    end
  end

  describe "mantissa" do
    it 'converts 1100.011 to its mantissa' do
      described_class.mantissa('1100.011').should == '10001100000000000000000'
    end
  end

  describe "#exponent_to_binary" do
    it 'gets the binary for the exponent 3' do
      described_class.exponent_to_binary(3).should == '10000010'
    end

    it 'gets the binary for the exponent 4' do
      described_class.exponent_to_binary(4).should == '10000011'
    end
  end

  describe "#convert_float_to_binary" do
    it 'converts 12.375 to its 32 bit binary' do
      described_class.convert_float_to_binary(12.375).should ==
        '0-10000010-10001100000000000000000'
    end

    it 'converts 12.25 to its 32 bit binary' do
      described_class.convert_float_to_binary(12.25).should ==
        '0-10000010-10001000000000000000000'
    end

    it 'converts 123.456 to its 32 bit binary' do
      described_class.convert_float_to_binary(123.456).should ==
        '0-10000101-11101101110100101111000'
    end

    xit 'converts 1.9999999 to its 32 bit binary' do
      described_class.convert_float_to_binary(1.9999999).should ==
        '0-01111111-11111111111111111111111'
    end

    it 'converst 0.0 to its 32 bit binary' do
      described_class.convert_float_to_binary(0.0).should ==
        '0-0000000000000000000000000000000'
    end
  end
end
