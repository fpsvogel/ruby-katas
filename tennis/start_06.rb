module Tennis
  class Game5
    attr_reader :player1_name, :player2_name, :player1_score, :player2_score

    def initialize(player1_name, player2_name)
      @player1_name = player1_name
      @player2_name = player2_name
      @player1_score = 0
      @player2_score = 0
    end

    def won_point(player_name)
      if player_name == "player1"
        @player1_score += 1
      else
        @player2_score += 1
      end
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
  end
end
