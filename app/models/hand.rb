class Hand
  attr_accessor :hand, :numbers

  def initialize(cards)
    @hand = cards
    @numbers = numbers_to_integers
  end
  #for testing this we will check the hand against all methods and the response should be only one
  #we could use a cyclic linked list but this works for 5 cards
  def straight?
    for i in 0..3
      return false if @numbers[i] + 1 != @numbers[i + 1] && (9 + @numbers[i]) != @numbers[i + 1]  #second one its for edge straigths 9 its a ciclic pivot if will be 6 cards it will be 8
    end
    return true
  end

  def numbers_to_integers
    numbers = []
    @hand.map{|card| card['number']}.each do |card|
      case card
      when "A"
        numbers << 14
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
    @numbers.find_all{ |e| @numbers.count(e) == 4 }.present?
  end

  def full_house?
    trio? && one_pair?
  end

  def flush? #or same suit
    @hand.map{|card| card['suit']}.uniq.count == 1
  end

  #this way can give some troubles in other cases and its O(n^2) but works great here and we only have arrays of 5
  def trio?
    @numbers.find_all{ |e| @numbers.count(e) == 3 }.uniq.count == 1
  end

  def two_pairs?
    @numbers.find_all{ |e| @numbers.count(e) == 2 }.uniq.count == 2
  end

  def one_pair?
    @numbers.find_all{ |e| @numbers.count(e) == 2 }.uniq.count == 1
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

  def untie
    return "tie" if rank == 10
    return untie_straigh_flush(1) if rank == 9
    return untie_four_of_a_kind(1) if rank == 8
  end

  def untie_straigh_flush(tie)
    @numbers[5-tie] #the biggest number and so on
  end

  def untie_four_of_a_kind(tie)
    return "dsa"
  end

end
