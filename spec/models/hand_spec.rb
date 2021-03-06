require 'rails_helper'

RSpec.describe Hand, type: :model do

  let(:straight) {[{"number"=>"10", "suit"=>"spades"}, {"number"=>"9", "suit"=>"hearts"}, {"number"=>"8", "suit"=>"hearts"},
              {"number"=>"7", "suit"=>"spades"}, {"number"=>"6", "suit"=>"hearts"}]}

  let(:edge_straight) {[{"number"=>"A", "suit"=>"spades"}, {"number"=>"2", "suit"=>"hearts"}, {"number"=>"K", "suit"=>"hearts"},
                          {"number"=>"Q", "suit"=>"spades"}, {"number"=>"J", "suit"=>"hearts"}]}

  let(:second_edge_straight) {[{"number"=>"A", "suit"=>"spades"}, {"number"=>"2", "suit"=>"hearts"}, {"number"=>"K", "suit"=>"hearts"},
                          {"number"=>"Q", "suit"=>"spades"}, {"number"=>"3", "suit"=>"hearts"}]}

  let(:flush)  {[{"number"=>"10", "suit"=>"spades"}, {"number"=>"4", "suit"=>"spades"}, {"number"=>"3", "suit"=>"spades"},
           {"number"=>"Q", "suit"=>"spades"}, {"number"=>"8", "suit"=>"spades"}]}

  let(:trio) {[{"number"=>"10", "suit"=>"spades"}, {"number"=>"10", "suit"=>"hearts"}, {"number"=>"8", "suit"=>"hearts"},
              {"number"=>"7", "suit"=>"spades"}, {"number"=>"10", "suit"=>"hearts"}]}

  let(:royal_flush) {[{"number"=>"10", "suit"=>"spades"}, {"number"=>"A", "suit"=>"spades"}, {"number"=>"K", "suit"=>"spades"},
              {"number"=>"J", "suit"=>"spades"}, {"number"=>"Q", "suit"=>"spades"}]}

  let(:straight_flush) {[{"number"=>"2", "suit"=>"hearts"}, {"number"=>"A", "suit"=>"hearts"}, {"number"=>"K", "suit"=>"hearts"},
              {"number"=>"J", "suit"=>"hearts"}, {"number"=>"Q", "suit"=>"hearts"}]}

  let(:fake_royal_flush) {[{"number"=>"9", "suit"=>"hearts"}, {"number"=>"A", "suit"=>"spades"}, {"number"=>"K", "suit"=>"spades"},
              {"number"=>"J", "suit"=>"spades"}, {"number"=>"Q", "suit"=>"hearts"}]}

  let(:four_of_a_kind) {[{"number"=>"9", "suit"=>"hearts"}, {"number"=>"9", "suit"=>"spades"}, {"number"=>"9", "suit"=>"spades"},
              {"number"=>"9", "suit"=>"spades"}, {"number"=>"Q", "suit"=>"hearts"}]}

  let(:full_house) {[{"number"=>"9", "suit"=>"hearts"}, {"number"=>"9", "suit"=>"spades"}, {"number"=>"9", "suit"=>"spades"},
              {"number"=>"A", "suit"=>"spades"}, {"number"=>"A", "suit"=>"hearts"}]}

  let(:two_pairs){[{"number"=>"9", "suit"=>"hearts"}, {"number"=>"9", "suit"=>"spades"}, {"number"=>"6", "suit"=>"spades"},
              {"number"=>"A", "suit"=>"spades"}, {"number"=>"A", "suit"=>"hearts"}]}

  let(:one_pair) {[{"number"=>"9", "suit"=>"hearts"}, {"number"=>"9", "suit"=>"spades"}, {"number"=>"6", "suit"=>"spades"},
              {"number"=>"A", "suit"=>"spades"}, {"number"=>"K", "suit"=>"hearts"}]}

  describe '#royal_flush?' do
    it 'should detect the royal flush' do
      hand = Hand.new(royal_flush)
      expect(hand.royal_flush?).to eq true
      expect(hand.rank).to eq 10
    end

    it 'should not detect the royal flush' do
      hand = Hand.new(fake_royal_flush)
      expect(hand.royal_flush?).to eq false
      expect(hand.rank).to eq 1
    end
  end

  describe '#straight_flush' do
    it ' should detect a straight_flush' do
      hand = Hand.new(straight_flush)
      expect(hand.straight_flush?).to eq true
      expect(hand.rank).to eq 9
    end
  end

  describe '#four_of_a_kind' do
    it ' should detect a four of a kind' do
      hand = Hand.new(four_of_a_kind)
      expect(hand.four_of_a_kind?).to eq true
      expect(hand.rank).to eq 8
    end
  end

  describe '#full_house' do
    it ' should detect a full house' do
      hand = Hand.new(full_house)
      expect(hand.full_house?).to eq true
      expect(hand.rank).to eq 7
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

    it 'should find straight in the edges' do
      hand = Hand.new(edge_straight)
      expect(hand.straight?).to eq true
      expect(hand.rank).to eq 5
    end

    it 'should find straight in the edges' do
      hand = Hand.new(second_edge_straight)
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

  describe '#two_pairs?' do
    it 'should detect the two pairs' do
      hand = Hand.new(two_pairs)
      expect(hand.two_pairs?).to eq true
      expect(hand.rank).to eq 3
    end
  end

  describe '#trio?' do
    it 'should detect trio' do
      hand = Hand.new(one_pair)
      expect(hand.one_pair?).to eq true
      expect(hand.rank).to eq 2
    end
  end

  describe '#high_card?' do
    it 'should detect a high card' do
      hand = Hand.new(fake_royal_flush)
      expect(hand.rank).to eq 1
    end
  end

end
