#gets the cards and delivers it to the players, he will deal with all the problems of getting the cards
class Croupier
  def initialize
    @token = nil
    @cards = nil
  end

  def get_cards(number_of_cards)
    return false if @token.nil?
    while @cards.nil?
      uri = URI("http://dealer.internal.comparaonline.com:8080/deck/#{@token}/deal/#{number_of_cards}")
      res = Net::HTTP.get(uri)
      cards = JSON.parse(res)
      @cards = cards unless cards["error"].present? #500., 404 token not found 405 not enough cards
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
    @cards.pop(cards_to_give) if @cards >= cards_to_give
  end

  def renew_token
    @token = nil
    self.get_token
  end
end
