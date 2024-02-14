module Tennis
  class Game2
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
end
