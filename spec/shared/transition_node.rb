
shared_examples_for 'a TransitionNode' do

  let(:node) { described_class.new() }
  subject { node }

  context 'when initialized' do
    its(:allows_entry) { should be_true }
    its(:allows_leave) { should be_true }
  end

  describe 'when entering' do
    
    it 'passed the node and transition to the event handler' do
      from = nil
      over = nil

      node.on_enter do |f, o|
        from = f
        over = o 
      end

      node.enter('node', 'trans')

      from.should == 'node'
      over.should == 'trans'
    end

    it 'calls all attached handlers' do
      count = 0
      
      node.on_enter do |f, o|
        count += 1
      end
      node.on_enter do |f|
        count += 1
      end
      node.on_enter do
        count += 1
      end

      node.enter(nil, nil)

      count.should == 3
    end

    it 'does not call on_leave' do
      called = false

      node.on_leave do
        called = true
      end

      node.enter(nil, nil)
      called.should be_false
    end
  end

  describe 'when leaving' do
    
    it 'passed the node and transition to the event handler' do
      from = nil
      over = nil

      node.on_leave do |f, o|
        from = f
        over = o 
      end

      node.leave('node', 'trans')

      from.should == 'node'
      over.should == 'trans'
    end

    it 'calls all attached handlers' do
      count = 0
      
      node.on_leave do |f, o|
        count += 1
      end
      node.on_leave do |f|
        count += 1
      end
      node.on_leave do
        count += 1
      end

      node.leave(nil, nil)
      count.should == 3
    end

    it 'does not call on_enter' do
      called = false

      node.on_enter do
        called = true
      end

      node.leave(nil, nil)
      called.should be_false
    end
  end
end
