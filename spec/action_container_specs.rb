
shared_examples_for 'an ActionContainer' do

  let(:container) { described_class.new() }

  context 'when initialized' do
    it { should_not have_action(:any) }

    it "raises an error when evaluating any action" do
      lambda { container.eval_action(:any) }.should raise_error
    end
  end

end
