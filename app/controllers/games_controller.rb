require "json"
require "open-uri"
require "uri"

class GamesController < ApplicationController
  def new
    alphabet = ("A".."Z").to_a
    @letters = alphabet.sample(10) # change this to the dynamic version you have in the old challenge
  end

  def score
      # raise
    guess = params[:guess]
    letters = params[:letters]
    @score = 0

    url = "https://wagon-dictionary.herokuapp.com/#{guess}"
    word_check = URI.open(url).read

    @word = JSON.parse(word_check)
    # implement here the logic to compute the score
    guess.each_char do |letter|
      unless letters.include?(letter.upcase)
        @wrong_letters = true
        break
      end
      @wrong_letters = false
    end
    @not_eng = true if @word["found"] == false
    if @wrong_letters != true && @not_eng != true
      @score = guess.length
    end
  end

  

end
