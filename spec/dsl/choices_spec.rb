require_relative '../../lib/dsl/choices'
require 'spec_helper'

class ChoicesContextMock
  include DSL::Choices

  attr_accessor :input
  attr_accessor :printed_text
  attr_accessor :unknown_called

  def puts(text)
    @printed_text = text 
  end

  def read_input
    @input
  end

  def unknown
    @unknown_called = true
  end
end

describe DSL::Choices do

  let(:context) { ChoicesContextMock.new() }

  context "When asking '[Fight] or [flee]?'" do
    let(:message) { '[Fight] or [flee]' }

    context "and answering 'flee'" do
      let(:answer) { 'flee' }

      before do
        context.input = answer
        @called_fight = false
        @called_flee = false
      end

      context "when an action for :flee is specified" do
        before do
          context.choice message, 
            fight:-> { @called_fight = true },
            flee:-> { @called_flee = true }
        end

        it 'excutes the :flee action' do
          @called_flee.should be_true
        end

        it 'does not excute the :fight action' do
          @called_fight.should be_false
        end

        it 'does not call for an unknown action' do
          context.unknown_called.should be_false
        end

        it 'prints the message' do
          context.printed_text.should == message
        end
      end

      context "when no action for :flee is specified" do
        before do
          context.choice message, 
            fight:-> { @called_fight = true },
            fea:-> { @called_flee = true }
        end

        it 'excutes none of the actions' do
          @called_flee.should be_false
          @called_fight.should be_false
        end

        it 'calls for an unknown action' do
          context.unknown_called.should be_true
        end

        it 'prints the message' do
          context.printed_text.should == message
        end
      end

      context 'when no action for :flee is specified but an action for :other' do
        before do
          context.choice message, 
            fight:-> { @called_fight = true },
            fea:-> { @called_flee = true },
            other:->(input) { 
              @input = input
              @called_other = true
            }
        end

        it 'excutes none of the normal actions' do
          @called_flee.should be_false
          @called_fight.should be_false
        end

        it 'executes the :other action' do
          @called_other.should be_true
        end

        it 'passes the entered text into the :other action' do
          @input.should == :flee
        end

        it 'does not call for an unknown action' do
          context.unknown_called.should be_false
        end

        it 'prints the message' do
          context.printed_text.should == message
        end
      end
    
    end
  end
end

