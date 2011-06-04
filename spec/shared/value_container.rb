require_relative '../../lib/value_container.rb'

shared_examples_for 'a ValueContainer' do

  let(:container) { described_class.new() }
  subject { container }

  context 'when initialized' do
    it { should_not have_value(:any) }
  end

  context 'after setting the value :safe' do
    before do
      container.set :safe
    end

    it { should have_value(:safe) }

    context 'and unsetting the value again' do
      before do
        container.unset :safe
      end

      it { should_not have_value(:safe) }
    end
  end

  context 'after setting the value :counter to 10' do
    before do
      container.set :counter, 10
    end

    it { should have_value(:counter) }
    it "should get the value 10 from the container" do
      container.get(:counter).should == 10
    end

  end

end
