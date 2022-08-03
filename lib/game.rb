class Game

  attr_reader :game_id,
              :season,
              :type,
              :teams_game_stats

  def initialize(game_csv_row)
    @game_id = game_csv_row[:game_id]
    @season = game_csv_row[:season]
    @type = game_csv_row[:type]
    @teams_game_stats = {home_team: nil, away_team: nil} #generate_team_stats(game_teams_csv_rows, home_name, away_name)
  end

  def generate_team_stats(data, home_or_away, team_name)
    @teams_game_stats[home_or_away]= {
      team_id: data[:team_id],
      team_name: team_name,
      goals: data[:goals],
      shots: data[:shots],
      tackles: data[:tackles],
      head_coach: data[:head_coach],
      face_off_win_percentage: data[:faceoffwinpercentage],
      result: data[:result]
    }
  end

  def total_goals
    @teams_game_stats[:home_team][:goals] + @teams_game_stats[:away_team][:goals]
  end

  def winner
    if @teams_game_stats[:home_team][:result] == "WIN"
      :home_team
    elsif @teams_game_stats[:home_team][:result] == "TIE"
      :tie
    else
      :away_team
    end
  end

  def team_stats(team_id)
    if team_id == @teams_game_stats[:home_team][:team_id]
      @teams_game_stats[:home_team]
    elsif team_id == @teams_game_stats[:away_team][:team_id]
      @teams_game_stats[:away_team]
    end
  end

  def team_in_game?(team_id)
    team_id == @teams_game_stats[:home_team][:team_id] || team_id == @teams_game_stats[:away_team][:team_id]
  end

  # def self.generate_games(games_csv, game_teams_csv, teams)
  #   game_array = []
  #   games_csv.each do |game|
  #     game_teams_csv_rows = game_teams_csv.find_all do |game_team|
  #       game_team[:game_id] == game[:game_id]
  #     end
  #     home_team = teams.values.find{ |team| team.team_id == game[:home_team_id] }
  #     away_team = teams.values.find{ |team| team.team_id == game[:away_team_id] }
  #     this_game = Game.new(game, game_teams_csv_rows, home_team.team_name, away_team.team_name)
  #     home_team.games_participated_in << this_game
  #     away_team.games_participated_in << this_game
  #     game_array << this_game
  #   end
  #   game_array
  # end

  def self.generate_games(games_csv, game_teams_csv, teams)
    game_hash = Hash.new
    games_csv.each do |game|
      game_hash[game[:game_id]] = Game.new(game)
    end
    game_teams_csv.each do |game_team|
      home_or_away = "#{game_team[:hoa]}_team".to_sym
      team_name = teams[game_team[:team_id]].team_name
      game_hash[game_team[:game_id]].generate_team_stats(game_team, home_or_away, team_name)
    end
    game_hash.values
  end
end
