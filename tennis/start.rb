class TennisGame
  def won_point
    raise NotImplementedError, "#{self.class} should have implemented #{__method__}"
  end

  def score
    raise NotImplementedError, "#{self.class} should have implemented #{__method__}"
  end

  def self.inherited(subclass)
    @subclasses ||= []
    @subclasses << subclass
  end

  def self.subclasses
    @subclasses
  end
end

class TennisGame1 < TennisGame
  def initialize(player1_name, player2_name)
    @player1_name = player1_name
    @player2_name = player2_name
    @player1_points = 0
    @player2_points = 0
  end

  def won_point(player_name)
    if player_name == "player1"
      @player1_points += 1
    else
      @player2_points += 1
    end
  end

  def score
    result = ""
    temp_score = 0

    if @player1_points == @player2_points
      result = {
        0 => "Love-All",
        1 => "Fifteen-All",
        2 => "Thirty-All",
      }.fetch(@player1_points, "Deuce")
    elsif @player1_points >= 4 || @player2_points >= 4
      minus_result = @player1_points - @player2_points

      if minus_result == 1
        result = "Advantage player1"
      elsif minus_result == -1
        result = "Advantage player2"
      elsif minus_result >= 2
        result = "Win for player1"
      else
        result = "Win for player2"
      end
    else
      2.times do |i|
        if i == 0
          temp_score = @player1_points
        else
          result += "-"
          temp_score = @player2_points
        end

        result += {
          0 => "Love",
          1 => "Fifteen",
          2 => "Thirty",
          3 => "Forty",
        }[temp_score]
      end
    end

    result
  end
end

class TennisGame2 < TennisGame
  def initialize(player1_name, player2_name)
    @player1_name = player1_name
    @player2_name = player2_name
    @player1_points = 0
    @player2_points = 0
  end

  def won_point(player_name)
    if player_name == @player1_name
      player1_score
    else
      player2_score
    end
  end

  def score
    result = ""

    if @player1_points == @player2_points && @player1_points < 3
      result = "Love" if @player1_points == 0
      result = "Fifteen" if @player1_points == 1
      result = "Thirty" if @player1_points == 2
      result += "-All"
    end

    result = "Deuce" if @player1_points == @player2_points && @player1_points > 2

    p1_result = ""
    p2_result = ""

    if @player1_points > 0 && @player2_points == 0
      p1_result = "Fifteen" if @player1_points == 1
      p1_result = "Thirty" if @player1_points == 2
      p1_result = "Forty" if @player1_points == 3

      p2_result = "Love"
      result = "#{p1_result}-#{p2_result}"
    end

    if @player2_points > 0 && @player1_points == 0
      p2_result = "Fifteen" if @player2_points == 1
      p2_result = "Thirty" if @player2_points == 2
      p2_result = "Forty" if @player2_points == 3

      p1_result = "Love"
      result = "#{p1_result}-#{p2_result}"
    end

    if @player1_points > @player2_points && @player1_points < 4
      p1_result = "Thirty" if @player1_points == 2
      p1_result = "Forty" if @player1_points == 3
      p2_result = "Fifteen" if @player2_points == 1
      p2_result = "Thirty" if @player2_points == 2
      result = "#{p1_result}-#{p2_result}"
    end

    if @player2_points > @player1_points && @player2_points < 4
      p2_result = "Thirty" if @player2_points == 2
      p2_result = "Forty" if @player2_points == 3
      p1_result = "Fifteen" if @player1_points == 1
      p1_result = "Thirty" if @player1_points == 2
      result = "#{p1_result}-#{p2_result}"
    end

    if @player1_points > @player2_points && @player2_points >= 3
      result = "Advantage #{@player1_name}"
    end

    if @player2_points > @player1_points && @player1_points >= 3
      result = "Advantage #{@player2_name}"
    end

    if @player1_points >= 4 && @player2_points >= 0 && (@player1_points - @player2_points) >= 2
      result = "Win for #{@player1_name}"
    end

    if @player2_points >= 4 && @player1_points >= 0 && (@player2_points - @player1_points) >= 2
      result = "Win for #{@player2_name}"
    end

    result
  end

  private

  def set_player1_score(number)
    (0..number).each do |i|
      player1_score
    end
  end

  def set_player2_score(number)
    (0..number).each do |i|
      player2_score
    end
  end

  def player1_score
    @player1_points += 1
  end

  def player2_score
    @player2_points += 1
  end
end

class TennisGame3 < TennisGame
  def initialize(player1_name, player2_name)
    @p1n = player1_name
    @p2n = player2_name
    @p1 = 0
    @p2 = 0
  end

  def won_point(n)
    if n == @p1n
      @p1 += 1
    else
      @p2 += 1
    end
  end

  def score
    if @p1 < 4 && @p2 < 4 && @p1 + @p2 < 6
      p = ["Love", "Fifteen", "Thirty", "Forty"]
      s = p[@p1]
      @p1 == @p2 ? "#{s}-All" : "#{s}-#{p[@p2]}"
    else
      if @p1 == @p2
        "Deuce"
      else
        s = @p1 > @p2 ? @p1n : @p2n
        (@p1 - @p2) * (@p1 - @p2) == 1 ? "Advantage #{s}" : "Win for #{s}"
      end
    end
  end
end

class TennisGame4 < TennisGame
  attr_reader :server, :receiver, :server_score, :receiver_score

  def initialize(player1, player2)
    @server = player1
    @receiver = player2
    @server_score = 0
    @receiver_score = 0
  end

  def score
    result = Deuce.new(
      self,
      GameServer.new(
        self,
        GameReceiver.new(
          self,
          AdvantageServer.new(
            self,
            AdvantageReceiver.new(
              self,
              DefaultResult.new(self),
            ),
          ),
        ),
      ),
    ).result

    result.format
  end

  def receiver_has_advantage
    @receiver_score >= 4 && (@receiver_score - @server_score) == 1
  end

  def server_has_advantage
    @server_score >= 4 && (@server_score - @receiver_score) == 1
  end

  def receiver_has_won
    @receiver_score >= 4 && (@receiver_score - @server_score) >= 2
  end

  def server_has_won
    @server_score >= 4 && (@server_score - @receiver_score) >= 2
  end

  def deuce?
    @server_score >= 3 && @receiver_score >= 3 && (@server_score == @receiver_score)
  end

  def won_point(player_name)
    if player_name == "player1"
      @server_score += 1
    else
      @receiver_score += 1
    end
  end
end

class TennisResult
  attr_reader :server_score, :receiver_score

  def initialize(server_score, receiver_score)
    @server_score = server_score
    @receiver_score = receiver_score
  end

  def format
    return @server_score if @receiver_score == ""

    if @server_score == @receiver_score
      "#{@server_score}-All"
    else
      "#{@server_score}-#{@receiver_score}"
    end
  end
end

class Deuce
  def initialize(game, next_result)
    @game = game
    @next_result = next_result
  end

  def result
    if @game.deuce?
      TennisResult.new("Deuce", "")
    else
      @next_result.result
    end
  end
end

class GameServer
  def initialize(game, next_result)
    @game = game
    @next_result = next_result
  end

  def result
    if @game.server_has_won
      TennisResult.new("Win for #{@game.server}", "")
    else
      @next_result.result
    end
  end
end

class GameReceiver
  def initialize(game, next_result)
    @game = game
    @next_result = next_result
  end

  def result
    if @game.receiver_has_won
      TennisResult.new("Win for #{@game.receiver}", "")
    else
      @next_result.result
    end
  end
end

class AdvantageServer
  def initialize(game, next_result)
    @game = game
    @next_result = next_result
  end

  def result
    if @game.server_has_advantage
      TennisResult.new("Advantage #{@game.server}", "")
    else
      @next_result.result
    end
  end
end

class AdvantageReceiver
  def initialize(game, next_result)
    @game = game
    @next_result = next_result
  end

  def result
    if @game.receiver_has_advantage
      TennisResult.new("Advantage #{@game.receiver}", "")
    else
      @next_result.result
    end
  end
end

class DefaultResult
  def initialize(game)
    @scores = ["Love", "Fifteen", "Thirty", "Forty"]
    @game = game
  end

  def result
    TennisResult.new(@scores[@game.server_score], @scores[@game.receiver_score])
  end
end

class TennisGame5 < TennisGame
  attr_reader :player1_name, :player2_name, :player1_score, :player2_score

  def initialize(player1_name, player2_name)
    @player1_name = player1_name
    @player2_name = player2_name
    @player1_score = 0
    @player2_score = 0
  end

  def score
    p1 = @player1_score
    p2 = @player2_score

    while p1 > 4 || p2 > 4
      p1 -= 1
      p2 -= 1
    end

    lookup = {
      0 => {
        0 => "Love-All",
        1 => "Love-Fifteen",
        2 => "Love-Thirty",
        3 => "Love-Forty",
        4 => "Win for #{@player2_name}",
      },
      1 => {
        0 => "Fifteen-Love",
        1 => "Fifteen-All",
        2 => "Fifteen-Thirty",
        3 => "Fifteen-Forty",
        4 => "Win for #{@player2_name}",
      },
      2 => {
        0 => "Thirty-Love",
        1 => "Thirty-Fifteen",
        2 => "Thirty-All",
        3 => "Thirty-Forty",
        4 => "Win for #{@player2_name}",
      },
      3 => {
        0 => "Forty-Love",
        1 => "Forty-Fifteen",
        2 => "Forty-Thirty",
        3 => "Deuce",
        4 => "Advantage #{@player2_name}",
      },
      4 => {
        0 => "Win for #{@player1_name}",
        1 => "Win for #{@player1_name}",
        2 => "Win for #{@player1_name}",
        3 => "Advantage #{@player1_name}",
        4 => "Deuce",
      }
    }

    lookup[p1][p2]
  end

  def won_point(player_name)
    if player_name == "player1"
      @player1_score += 1
    else
      @player2_score += 1
    end
  end
end

class TennisGame6 < TennisGame
  attr_reader :player1_name, :player2_name, :player1_score, :player2_score

  def initialize(player1_name, player2_name)
    @player1_name = player1_name
    @player2_name = player2_name
    @player1_score = 0
    @player2_score = 0
  end

  def won_point(player_name)
    player_name == "player1" ? @player1_score += 1 : @player2_score += 1
  end

  def score
    if @player1_score == @player2_score
      tie_score
    elsif @player1_score >= 4 || @player2_score >= 4
      end_game_score
    else
      regular_score
    end
  end

  private

  def tie_score
    case @player1_score
    when 0
      "Love-All"
    when 1
      "Fifteen-All"
    when 2
      "Thirty-All"
    else
      "Deuce"
    end
  end

  def end_game_score
    if @player1_score - @player2_score == 1
      "Advantage #{@player1_name}"
    elsif @player1_score - @player2_score == -1
      "Advantage #{@player2_name}"
    elsif @player1_score - @player2_score >= 2
      "Win for #{@player1_name}"
    else
      "Win for #{@player2_name}"
    end
  end

  def regular_score
    score_names = %w[Love Fifteen Thirty Forty]
    "#{score_names[@player1_score]}-#{score_names[@player2_score]}"
  end
end

