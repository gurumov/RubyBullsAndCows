class BCLogic
  attr_accessor :opponent_guesses, :player_guesses

  def initialize(player_number, singleplayer=true, opponent_number=0)
    @player_number = player_number.to_s
    @opponent_number = singleplayer ? Array(0..9).sample(4).join : opponent_number.to_s
    @singleplayer = singleplayer
    if singleplayer
      @choices = Array(0..9).permutation(4).map { |n| n.join }
    end
    @opponent_guesses = []
    @player_guesses = []
  end

  def self.valid_number?(guess)
    guess.to_s.chars.uniq.size == 4
  end

  def player_guess(number)
    @player_guesses.push(number.to_s) 
    result = find_bulls_cows(number.to_s, @opponent_number)
    @player_guesses.concat result
    result[0] == 4
  end

  def opponent_guess(*args)
    guess = @singleplayer ? guess_number : args[0].to_s
    @opponent_guesses.push(guess)
    result = find_bulls_cows(@player_number, guess)
    @opponent_guesses.concat result
    result[0] == 4
  end

  def find_bulls_cows(first_number, second_number)
    first_number  = first_number.to_s
    second_number = second_number.to_s

    bulls = first_number.chars.zip(second_number.chars).each.count do |element|
      element.first == element.last
    end

    cows = (first_number.chars & second_number.chars).count - bulls

    [bulls, cows]
  end

  private

  def guess_number
    unless @opponent_guesses.empty?
      last_guess = @opponent_guesses[-3]
      result = [@opponent_guesses[-2], @opponent_guesses[-1]]
      @choices.delete last_guess
      @choices.keep_if { |number|  result.eql? find_bulls_cows(last_guess, number)}
    end
    @choices.shuffle!
    @choices[0]
  end
end
