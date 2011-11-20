require_relative '../lib/array_ext'

describe Array, "Extensions" do

  describe '#append_unique!' do
    it 'returns a singleton when appending to an empty array' do
      ([].append_unique! 1).should == [1]   
    end

    it 'returns the array unchanged when appending an existing item' do
      ([1,2,3].append_unique! 2).should == [1,2,3]
    end

    it 'returns the array with the item appended at the end when appending a not yet existing item' do
      ([1,2,3].append_unique! 0).should == [1,2,3,0]
    end
  end

end
