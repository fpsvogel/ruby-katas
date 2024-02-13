# TODO: clean up versions 1, 2, 3 below
# TODO: add versions 4, 5, && 6 from https://github.com/emilybache/Tennis-Refactoring-Kata/tree/main/typescript/src

class TennisGame1
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

class TennisGame2
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

class TennisGame3
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
