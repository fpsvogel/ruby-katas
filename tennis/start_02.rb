module Tennis
  class Game3
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
end
