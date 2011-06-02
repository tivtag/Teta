require_relative '../lib/string_ext'

describe String, "Extensions" do

  describe '#start_set' do
    context "given the string 'world'" do
      let(:result) { 'world'.start_set }
      subject { result }

      it { should == %w{w wo wor worl world} }
    end
  end

end
