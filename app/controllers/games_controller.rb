require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(8)
  end

  def score
    @letters = params[:letters]
    @word = params[:word].downcase
    @url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    @file = open(@url).read
    @status = JSON.parse(@file)
    @new_word = @letters.split(" ")
    @vaild = true
    @word.split("").each do |x|
      if !@new_word.include?(x)
        @vaild = false
      end
    end
    if @status['found'] && @vaild
      @response = 'Great! You get one!'
    else
      @response = 'Oops, try it next time'
    end
  end
end
