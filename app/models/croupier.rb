#gets the cards and delivers it to the players, he will deal with all the problems of getting the cards
class Croupier

  attr_accessor :token, :cards

  def initialize
    @token = nil
    @cards = nil
  end

  def add_cards(new_cards)
    if @cards.nil?
       @cards = new_cards
    else
      @cards += new_cards
    end
  end

  def get_cards(number_of_cards)
    return false if @token.nil?
    new_cards = nil
    while new_cards.nil? || new_cards.is_a?(Hash)#hash its always some error
      uri = URI("http://dealer.internal.comparaonline.com:8080/deck/#{@token}/deal/#{number_of_cards}")
      res = Net::HTTP.get(uri)
      new_cards = JSON.parse(res)
      self.add_cards(new_cards) unless new_cards.is_a?(Hash) #500., 404 token not found 405 not enough cards
    end
  end

  def get_token
    while @token.nil? || @token.length != 36 do
      uri = URI.parse("http://dealer.internal.comparaonline.com:8080/deck")
      res = Net::HTTP.post_form(uri, 'q' => 'ruby', 'max' => '50')
      @token = res.body if res.body.length == 36
    end
  end

  def give_cards(cards_to_give)
    return @cards.pop(cards_to_give) if @cards.size >= cards_to_give
    return []
  end

  def renew_token
    @token = nil
    self.get_token
  end

  def shuffle_deck
    @token = nil
    @cards = nil
    self.get_token
  end
end
