
shared_examples_for 'a GameContext' do

  let(:context) { described_class.new() }
  subject { context }

  context 'when initialized' do
    its(:player) { should be_nil }
  end

  context 'when Player is set' do
    before do
      context.player = Player.new
    end

    its(:player) { should_not be_nil }

    context 'when another context is setup from that GameConext' do
      before do
        @other_context = Object.new
        @other_context.extend GameContext

        @other_context.setup_context(context)
      end

      it 'should have the same Player Objects' do
        @other_context.player.should == context.player
      end
    end
  end

end
