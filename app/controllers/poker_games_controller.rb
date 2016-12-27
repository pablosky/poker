class PokerGames < ApplicationController

  def welcome
  end

  def game
    #start
    game = PokerGame.new
    #playing
    if params[:play].present?
      alfred.shuffle_deck if alfred.cards < 10
      bruce = Hand.new(alfred.give_cards(5))
      felicia = Hand.new(alfred.give_cards(5))
      #winner
      if bruce.rank == felicia.rank
        winner = "its a tie!"
      elsif bruce.rank > felicia.rank
        winner = "bruce has won! with a #{I18n.t('ranks')[bruce.rank -1]}"
      else
        winner = "felicia has won! with a #{I18n.t('ranks')[felicia.rank -1]}"
      end
    elsif params[:shuffle].present?
      alfred.shuffle_deck
    end
  end

end
