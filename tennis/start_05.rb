require_relative "tennis_game_base"

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
