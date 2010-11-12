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

end
