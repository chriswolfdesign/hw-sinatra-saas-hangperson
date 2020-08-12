class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  # accessors
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  # @return [boolean] True if the letter was in the word, false otherwise
  def guess(letter)

    unless letter?(letter)
      raise ArgumentError.new
    end

    # convert the letter to lowercase
    letter.downcase!

    # if the letter has already been guesses, return false and quit
    if @guesses.include? letter or @wrong_guesses.include? letter
      return false
    end

    if @word.include? letter
      @guesses += letter
    else
      @wrong_guesses += letter
    end

    true
  end

  # @return [string] @word where all letters that have not yet been guessed
  # are replaced with dashes
  def word_with_guesses
    word_to_display = ''

    @word.split('').each do |letter|
      if @guesses.include? letter
        word_to_display += letter
      else
        word_to_display += '-'
      end
    end

    return word_to_display
  end

  # @return [Symbol] :win if the player has won, :lose if the player has lost
  # or :play if the game is still going
  def check_win_or_lose
    if self.won?
      return :win
    end

    if self.lost?
      return :lose
    end

    # if the player has not won or lost, the game must still be going
    :play
  end

  # @return [boolean] true if the player has won, false otherwise
  def won?
    # if any letters in the word have not been guessed, the player has not won
    @word.split('').each do |letter|
      unless @guesses.include? letter
        return false
      end
    end

    # if ever letter in word has been guessed, the player has won
    return true
  end

  # @return [boolean] true if the player has lost, false otherwise
  def lost?
    @wrong_guesses.length >= 7
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end

# @return true if the given letter is a character, false otherwise
def letter?(letter)
  letter =~ /[A-Za-z]/
end