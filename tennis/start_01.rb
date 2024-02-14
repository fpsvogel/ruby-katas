require_relative "tennis_game_base"

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
