
shared_examples_for 'a GameContext' do

  let(:provider) { described_class.new() }
  subject { provider }

  context 'when initialized' do
    its(:player) { should be_nil }
  end

  context 'when Player is set' do
    before do
      provider.player = Player.new
    end

    its(:player) { should_not be_nil }
  end

end
