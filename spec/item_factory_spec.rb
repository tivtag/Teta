require_relative '../lib/item_factory'
require 'spec_helper'

describe ItemFactory do

  let(:factory) { ItemFactory.new }

  describe '#create' do

    it 'creates an Item that has the given name' do
      item = factory.create(:apple)
      item.name.should == :apple
    end    

  end

end
