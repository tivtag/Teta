require_relative '../lib/game_context'

describe GameContext do

  context 'when initialized' do
    let(:context) { GameContext.new }
    subject { context }

    its(:player) { should be_nil }

    context 'after the player is set' do
      before do
        context.player = Player.new
      end

      its(:player) { should_not be_nil }
    end
  end

end
