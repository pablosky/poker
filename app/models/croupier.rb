#gets the cards and delivers it to the players, he will deal with all the problems of getting the cards
class Croupier < ActiveRecord::Base

  serialize :cards, Array

  def add_cards(new_cards)
    if cards.blank?
       self.cards = new_cards
    else
      self.cards += new_cards
    end
    self.save
  end

  def get_cards(number_of_cards)
    return false if token.nil?
    new_cards = nil
    while new_cards.nil? || new_cards.is_a?(Hash)#hash its always some error
      uri = URI("http://dealer.internal.comparaonline.com:8080/deck/#{token}/deal/#{number_of_cards}")
      res = Net::HTTP.get(uri)
      new_cards = JSON.parse(res)
      self.add_cards(new_cards) unless new_cards.is_a?(Hash) #500., 404 token not found 405 not enough cards
    end
  end

  def get_token
    while token.nil? || token.length != 36 do
      uri = URI.parse("http://dealer.internal.comparaonline.com:8080/deck")
      res = Net::HTTP.post_form(uri, 'q' => 'ruby', 'max' => '50')
      self.token = res.body if res.body.length == 36
    end
  end

  def give_cards(cards_to_give)
    if cards.size >= cards_to_give
      c = self.cards.pop(cards_to_give)
      self.save
      return c
    else
      return []
    end
  end

  def renew_token
    token = nil
    self.get_token
    self.save
  end

  def shuffle_deck
    self.token = nil
    self.cards = nil
    self.get_token
    self.get_cards(52)
  end
end
