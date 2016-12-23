require 'rails_helper'

RSpec.describe Croupier, type: :model do

  before (:each) do
    @barney = Croupier.new
    @barney.add_cards([{"number"=>"Q", "suit"=>"clubs"}, {"number"=>"10", "suit"=>"diamonds"}, {"number"=>"8", "suit"=>"spades"}])
    response_cards = "[{\"number\":\"9\",\"suit\":\"clubs\"},{\"number\":\"3\",\"suit\":\"diamonds\"}]"
    @response_token = "299d5940-c8c1-11e6-9c4b-b5d17f2932f5"
    @error_token =  "{\"statusCode\":500,\"error\":\"Internal Server Error\",\"message\":\"An internal server error occurred\"}"
  end

  describe '#add_cards' do
    it 'should add cards' do
      expect(@barney.cards.size).to eq 3
      @barney.add_cards([{"number"=>"9", "suit"=>"clubs"}, {"number"=>"3", "suit"=>"diamonds"}])
      expect(@barney.cards.size).to eq 5
    end
  end

  describe '#give_cards' do
    it 'should give the number asked of cards' do
      cards = @barney.give_cards(2)
      expect(cards.size).to eq 2
      expect(@barney.cards.size).to eq 1
    end

    it 'should not give cards if doesnt have enough' do
      cards = @barney.give_cards(4)
      expect(cards).to eq []
    end
  end

  describe '#get_token' do
    it 'should get the token and save it in the instance' do
      stub_request(:any, "http://dealer.internal.comparaonline.com:8080/deck").to_return(:body => @response_token, :status => 200, :headers => {})
      ted = Croupier.new
      ted.get_token
      expect(ted.token).to eq "299d5940-c8c1-11e6-9c4b-b5d17f2932f5"
    end

    it 'should keep trying until it gets the token' do
      stub_request(:any, "http://dealer.internal.comparaonline.com:8080/deck").to_return({body: @error_token, status: 500, headers: {}},{body: @response_token, status: 200, headers: {}})
      ted = Croupier.new
      ted.get_token
      expect(ted.token).to eq "299d5940-c8c1-11e6-9c4b-b5d17f2932f5"
    end
  end


end
