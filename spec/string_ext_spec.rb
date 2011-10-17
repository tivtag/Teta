require_relative '../lib/string_ext'

describe String, "Extensions" do

  describe '#start_with_any?' do
    context "given the string 'hello'" do

      ['h', 'he', 'hel', 'hell', 'hello'].each do |text|
        it "should start with '#{text}'" do
          "hello".start_with_any?(text).should be_true
        end
      end

      ['ell', 'ol', 'el', 'heko', 'meow', ''].each do |text|
        it "should not start with '#{text}'" do
          "hello".start_with_any?(text).should be_false
        end
      end

    end
  end

  describe '#start_set' do
    context "given the string 'world'" do
      let(:result) { 'world'.start_set }
      subject { result }

      it { should == %w{w wo wor worl world} }
    end
  end

end
