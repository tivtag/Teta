
shared_examples_for 'a GameContextProvider' do

  let(:provider) { described_class.new() }
  subject { provider }

  context 'when no context is set' do
    it 'raises an error when trying to get the player object' do
      lambda {provider.player}.should raise_error
    end
  end

  context 'when the context is set' do
    before do
       context = GameContext.new
       context.player = Player.new

       provider.context = context
    end

    its(:player) { should_not be_nil }
  end

end
