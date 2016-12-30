class Hand
  attr_accessor :hand, :numbers, :name

  def initialize(cards)
    @hand = cards
    @numbers = numbers_to_integers
    @name = name
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

  def untie(tie)
    #a final tie its nil for all unties, if both have royal flush its always a tie
    return untie_straigh(tie) if [1, 9, 6, 5].include?(rank)
    return untie_four_of_a_kind(tie) if rank == 8
    return untie_full_house(tie) if rank == 7
    return untie_trio(tie) if rank == 4
    return untie_two_pairs(tie) if rank == 3
    return untie_pair(tie) if rank == 2
  end

  def untie_straigh(tie) #or untie straigths and royal flush all the same
    @numbers[5-tie] #the biggest number and so on
  end

  def untie_four_of_a_kind(tie)
    return @numbers.find_all{ |e| @numbers.count(e) == 4 }.sum if tie == 1
    return @numbers.find_all{ |e| @numbers.count(e) == 1 }.sum if tie == 2
  end

  def untie_full_house(tie)
    return @numbers.find_all{ |e| @numbers.count(e) == 3 }.sum if tie == 1
    return @numbers.find_all{ |e| @numbers.count(e) == 2 }.sum if tie == 2
  end

  def untie_two_pairs(tie)
    return @numbers.find_all{ |e| @numbers.count(e) == 2 }.uniq.sort.last if tie == 1#highest pair
    return @numbers.find_all{ |e| @numbers.count(e) == 2 }.uniq.sort.first if tie == 2 #second highest pair
    return @numbers.find_all{ |e| @numbers.count(e) == 1 }.first if tie ==3 #high lonely card
  end

  def untie_trio(tie)
    return @numbers.find_all{ |e| @numbers.count(e) == 3 }.uniq.first if tie == 1
    return @numbers.find_all{ |e| @numbers.count(e) == 1 }.sort.last if tie == 2
    return @numbers.find_all{ |e| @numbers.count(e) == 1 }.sort.first if tie == 3
  end

  def untie_pair(tie)
    #this can be definetly improved
    return @numbers.find_all{ |e| @numbers.count(e) == 2 }.uniq.sort.last if tie == 1
    return @numbers.find_all{ |e| @numbers.count(e) == 1 }.uniq.sort.last if tie == 2
    return @numbers.find_all{ |e| @numbers.count(e) == 1 }.uniq.sort.second if tie == 3
    return @numbers.find_all{ |e| @numbers.count(e) == 1 }.uniq.sort.first if tie == 4
  end

end
