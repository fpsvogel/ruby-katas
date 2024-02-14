TEST_CASES = [
   [0, 0, "Love-All", "player1", "player2"],
   [1, 1, "Fifteen-All", "player1", "player2"],
   [2, 2, "Thirty-All", "player1", "player2"],
   [3, 3, "Deuce", "player1", "player2"],
   [4, 4, "Deuce", "player1", "player2"],

   [1, 0, "Fifteen-Love", "player1", "player2"],
   [0, 1, "Love-Fifteen", "player1", "player2"],
   [2, 0, "Thirty-Love", "player1", "player2"],
   [0, 2, "Love-Thirty", "player1", "player2"],
   [3, 0, "Forty-Love", "player1", "player2"],
   [0, 3, "Love-Forty", "player1", "player2"],
   [4, 0, "Win for player1", "player1", "player2"],
   [0, 4, "Win for player2", "player1", "player2"],

   [2, 1, "Thirty-Fifteen", "player1", "player2"],
   [1, 2, "Fifteen-Thirty", "player1", "player2"],
   [3, 1, "Forty-Fifteen", "player1", "player2"],
   [1, 3, "Fifteen-Forty", "player1", "player2"],
   [4, 1, "Win for player1", "player1", "player2"],
   [1, 4, "Win for player2", "player1", "player2"],

   [3, 2, "Forty-Thirty", "player1", "player2"],
   [2, 3, "Thirty-Forty", "player1", "player2"],
   [4, 2, "Win for player1", "player1", "player2"],
   [2, 4, "Win for player2", "player1", "player2"],

   [4, 3, "Advantage player1", "player1", "player2"],
   [3, 4, "Advantage player2", "player1", "player2"],
   [5, 4, "Advantage player1", "player1", "player2"],
   [4, 5, "Advantage player2", "player1", "player2"],
   [15, 14, "Advantage player1", "player1", "player2"],
   [14, 15, "Advantage player2", "player1", "player2"],

   [6, 4, "Win for player1", "player1", "player2"],
   [4, 6, "Win for player2", "player1", "player2"],
   [16, 14, "Win for player1", "player1", "player2"],
   [14, 16, "Win for player2", "player1", "player2"],

   [6, 4, "Win for player1", "player1", "player2"],
   [4, 6, "Win for player2", "player1", "player2"],
   [6, 5, "Advantage player1", "player1", "player2"],
   [5, 6, "Advantage player2", "player1", "player2"]
]

class TestTennis < Minitest::Test
  def play_game(tennis_game_class, player1_points, player2_points, player1_name, player2_name)
    game = tennis_game_class.new(player1_name, player2_name)

    (0..[player1_points, player2_points].max).each do |i|
      if i < player1_points
        game.won_point(player1_name)
      end

      if i < player2_points
        game.won_point(player2_name)
      end
    end

    game
  end

  max_variant = 0
  while Tennis.const_defined?("Game#{max_variant + 1}")
    max_variant += 1
  end

  1.upto(max_variant) do |variant_n|
    define_method("test_score_for_variant_#{variant_n}") do
      tennis_game_class = Tennis.const_get("Game#{variant_n}")

      TEST_CASES.each do |test_case|
        player1_points, player2_points, score, player1_name, player2_name = test_case
        game = play_game(tennis_game_class, player1_points, player2_points, player1_name, player2_name)

        assert_equal(score, game.score)
      end
    end
  end
end
