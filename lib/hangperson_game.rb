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

    if not letter?(letter)
      raise ArgumentError.new()
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

    return true
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

# @return [boolean] true if the given letter is a character, false otherwise
def letter?(letter)
  return letter =~ /[A-Za-z]/
end