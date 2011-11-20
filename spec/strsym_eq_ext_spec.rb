require_relative '../lib/strsym_eq_ext.rb'

describe String, 'Equivalence' do

  describe 'when comparing a String to a Symbol for equality' do
    it "returns true if they match" do
      ("cats" == :cats).should be_true
    end

    it "returns false if they do not match" do
      ("fish" == :cats).should be_false
    end
  end

  describe 'when comparing a String to any other object' do
    it 'returns the expected result' do
      ("cats" == 3).should be_false
      ("cats" == "cats").should be_true
      ("fish" == "cats").should be_false
      ("cats" == nil).should be_false
    end
  end

end

describe Symbol, 'Equivalence' do

  describe 'when comparing a Symbol to a String for equality' do
    it "returns true if they match" do
      (:cats == "cats").should be_true
    end

    it "returns false if they do not match" do
      (:fish == "cats").should be_false
    end
  end

  describe 'when comparing a Symbol to any other object' do
    it 'returns the expected result' do
      (:cats == 3).should be_false
      (:cats == :cats).should be_true
      (:fish == :cats).should be_false
      (:cats == nil).should be_false
    end
  end

end
