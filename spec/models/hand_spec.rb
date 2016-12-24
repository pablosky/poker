require 'rails_helper'

RSpec.describe Hand, type: :model do

  let(:straight) {[{"number"=>"10", "suit"=>"spades"}, {"number"=>"9", "suit"=>"hearts"}, {"number"=>"8", "suit"=>"hearts"},
              {"number"=>"7", "suit"=>"spades"}, {"number"=>"6", "suit"=>"hearts"}]}
  let(:flush)  {[{"number"=>"10", "suit"=>"spades"}, {"number"=>"4", "suit"=>"spades"}, {"number"=>"3", "suit"=>"spades"},
           {"number"=>"Q", "suit"=>"spades"}, {"number"=>"8", "suit"=>"spades"}]}

  let(:trio) {[{"number"=>"10", "suit"=>"spades"}, {"number"=>"10", "suit"=>"hearts"}, {"number"=>"8", "suit"=>"hearts"},
              {"number"=>"7", "suit"=>"spades"}, {"number"=>"10", "suit"=>"hearts"}]}

  let(:royal_flush) {[{"number"=>"10", "suit"=>"spades"}, {"number"=>"A", "suit"=>"spades"}, {"number"=>"K", "suit"=>"spades"},
              {"number"=>"J", "suit"=>"spades"}, {"number"=>"Q", "suit"=>"spades"}]}
  let(:fake_royal_flush) {[{"number"=>"10", "suit"=>"hearts"}, {"number"=>"A", "suit"=>"spades"}, {"number"=>"K", "suit"=>"spades"},
              {"number"=>"J", "suit"=>"spades"}, {"number"=>"Q", "suit"=>"hearts"}]}

  describe '#royal_flush?' do
    it 'should detect the royal flush' do
      hand = Hand.new(royal_flush)
      expect(hand.royal_flush?).to eq true
      expect(hand.rank).to eq 10
    end

    it 'should detect the royal flush' do
      hand = Hand.new(fake_royal_flush)
      expect(hand.royal_flush?).to eq false
      expect(hand.straight?).to eq true
      expect(hand.rank).to eq 6
    end
  end

  describe '#flush?' do
    it 'should detect the straight and no other type of thing' do
      hand = Hand.new(flush)
      expect(hand.flush?).to eq true
      expect(hand.rank).to eq 6
    end
  end

  describe '#straight?' do
    it 'should detect the straight and no other type of thing' do
      hand = Hand.new(straight)
      expect(hand.straight?).to eq true
      expect(hand.rank).to eq 5
    end
  end

  describe '#trio?' do
    it 'should detect trio' do
      hand = Hand.new(trio)
      expect(hand.trio?).to eq true
      expect(hand.rank).to eq 4
    end
  end

end
