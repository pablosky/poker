class Hand
  attr_accessor :hand, :numbers

  def initialize(cards)
    @hand = cards
    @numbers = numbers_to_integers
  end
  #for testing this we will check the hand against all methods and the response should be only one
  #i can test all flushes in one method!
  def straight?
    for i in 0..3
      return false if @numbers[i] + 1 != @numbers[i + 1]
    end
    return true
  end

  def numbers_to_integers
    numbers = []
    @hand.map{|card| card['number']}.each do |card|
      case card
      when "A"
        numbers << 1
      when "K"
        numbers << 13
      when "Q"
        numbers << 12
      when "J"
        numbers << 11
      else
        numbers << card.to_i
      end
    end
    return numbers.sort
  end

  def royal_flush?
    royal = (@hand.map{|card| card['number']} - ["A", "K", "Q", "J", "10"]).empty?
    royal && flush?
  end

  def straight_flush?
     straight? && flush?
  end

  def four_of_a_kind?
    return @numbers.find_all{ |e| @numbers.count(e) == 4 }.present?
  end

  def full_house?
    trio? && one_pair?
  end

  def flush? #or same suit
    @hand.map{|card| card['suit']}.uniq.count == 1
  end

  #this way can give some troubles in other cases and its O(n^2) but works great here and we only have arrays of 5
  def trio?
    return @numbers.find_all{ |e| @numbers.count(e) == 3 }.uniq.count == 1
  end

  def two_pairs?
    return @numbers.find_all{ |e| @numbers.count(e) == 2 }.uniq.count == 2
  end

  def one_pair?
    return @numbers.find_all{ |e| @numbers.count(e) == 2 }.uniq.count == 1
  end

  def high_card
    @numbers.last
  end

  #from 10 to 1
  def rank
    return 10 if royal_flush?
    return 9 if straight_flush?
    return 8 if four_of_a_kind?
    return 7 if full_house?
    return 6 if flush?
    return 5 if straight?
    return 4 if trio?
    return 3 if two_pairs?
    return 2 if one_pair?
    return 1
  end

end
