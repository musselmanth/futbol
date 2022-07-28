module GameStats

  def average_goals_per_game
    total_goals = @games.sum{ |game| game.total_goals }
    (total_goals.to_f / @games.length).round(2)
  end

  def percentage_ties
    total_tie_games = @games.count{|game| game.teams_game_stats[:home_team][:goals] == game.teams_game_stats[:away_team][:goals]}
    (total_tie_games.to_f / @games.length).round(2)
  end

end
