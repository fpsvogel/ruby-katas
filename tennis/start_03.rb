module Tennis
  class Game1
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
end
