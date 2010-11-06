
shared_examples_for 'an ActionContainer' do

  let(:container) { described_class.new() }
  subject { container }

  context 'when initialized' do
    it { should_not have_action(:any) }

    it "raises an error when evaluating any action" do
      lambda { container.eval_action(:any) }.should raise_error
    end
  end

  context 'after adding an action' do
    
    before do
      container.add_action :the_action do
         self.has_action?(:the_action)
      end
    end

    it { should have_action(:the_action) }
    it { should_not have_action(:another_action) }

    context 'when evaluating the action' do
      it 'evaluates the action within the context of the container' do
         result = container.eval_action(:some_action)
         result.should be_true
      end
    end

  end

end
