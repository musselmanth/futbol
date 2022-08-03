require 'csv'
require_relative './team'
require_relative './game'
require_relative './season'
require_relative './game_stats'
require_relative './league_stats'

class StatTracker
  include GameStats
  include LeagueStats

  attr_reader :games,
              :teams,
              :seasons

  def initialize(games, teams, seasons)
    @teams = teams
    @games = games
    @seasons = seasons
  end

  def self.from_csv(locations)
    teams = Team.generate_teams(locations[:teams])
    games = Game.generate_games(locations[:games], locations[:game_teams], teams)
    seasons = Season.generate_seasons(games)
    StatTracker.new(games, teams, seasons)
  end

  def most_accurate_team(season) @seasons[season.to_i].most_accurate_team(season) end
  def least_accurate_team(season) @seasons[season.to_i].least_accurate_team(season) end
  def most_tackles(season) @seasons[season.to_i].most_tackles end
  def fewest_tackles(season) @seasons[season.to_i].fewest_tackles end
  def winningest_coach(season) @seasons[season.to_i].winningest_coach end
  def worst_coach(season) @seasons[season.to_i].worst_coach end

  def rival(team) @teams[team.to_i].rival end
  def favorite_opponent(team) @teams[team.to_i].favorite_opponent end
  def best_season(team) @teams[team.to_i].best_season end
  def worst_season(team) @teams[team.to_i].worst_season end
  def average_win_percentage(team) @teams[team.to_i].average_win_percentage  end
  def most_goals_scored(team) @teams[team.to_i].most_goals_scored end
  def fewest_goals_scored(team) @teams[team.to_i].fewest_goals_scored end
  def team_info(team) @teams[team.to_i].team_info end

end
