class PokerGamesController < ApplicationController

  def welcome
  end

  def game
    #start
    #game = PokerGame.new
    if params[:start].present?
      @alfred = Croupier.new
      @alfred.shuffle_deck
    end
    #playing
    if params[:play].present? && params[:croupier].present?
      @alfred = Croupier.find(params[:croupier]) #lets assume that the id is correct
      @alfred.shuffle_deck if @alfred.cards.count < 10 || params[:shuffle].present?
      @bruce = Hand.new(@alfred.give_cards(5))
      @felicia = Hand.new(@alfred.give_cards(5))
      #winner
      if @bruce.rank == @felicia.rank
        @winner = "its a tie!"
      elsif @bruce.rank > @felicia.rank
        @winner = "bruce has won! with #{I18n.t('ranks')[@bruce.rank() -1]}"
      else
        @winner = "felicia has won! with  #{I18n.t('ranks')[@felicia.rank() -1]} "
      end
      @hands = [@bruce, @felicia]
    end
  end


end
