//// Now with better types, using type aliases and a Dict

import gleam/dict
import gleam/int
import gleam/list
import gleam/option
import gleam/order
import gleam/string

const header = "Team                           | MP |  W |  D |  L |  P"

type LeagueTable =
  dict.Dict(String, Stats)

type Team =
  #(String, Stats)

type Stats {
  Stats(played: Int, won: Int, drawn: Int, lost: Int, points: Int)
}

fn create_stats() -> Stats {
  Stats(0, 0, 0, 0, 0)
}

pub fn tally(input: String) -> String {
  input
  |> string.split(on: "\n")
  |> parse_lines(dict.new())
  |> dict.to_list()
  |> list.sort(by: team_compare)
  |> to_string
}

fn parse_lines(lines: List(String), table: LeagueTable) -> LeagueTable {
  case lines {
    [] -> table
    [line, ..rest] -> parse_lines(rest, parse_line(line, table))
  }
}

fn parse_line(line: String, table: LeagueTable) -> LeagueTable {
  case line |> string.split(on: ";") |> list.map(with: string.trim) {
    [team1, team2, result] -> add_result(table, team1, team2, result)
    _ -> table
  }
}

fn add_result(
  table: LeagueTable,
  name1: String,
  name2: String,
  result: String,
) -> LeagueTable {
  table
  |> dict.upsert(name1, fn(stats) {
    update_stats(option.lazy_unwrap(stats, create_stats), result)
  })
  |> dict.upsert(name2, fn(stats) {
    update_stats(
      option.lazy_unwrap(stats, create_stats),
      reverse_result(result),
    )
  })
}

fn reverse_result(result: String) -> String {
  case result {
    "win" -> "loss"
    "loss" -> "win"
    _ -> result
  }
}

fn update_stats(stats: Stats, result: String) -> Stats {
  let Stats(played, won, drawn, lost, points) = stats
  case result {
    "win" ->
      Stats(..stats, played: played + 1, won: won + 1, points: points + 3)
    "draw" ->
      Stats(..stats, played: played + 1, drawn: drawn + 1, points: points + 1)
    "loss" -> Stats(..stats, played: played + 1, lost: lost + 1)
    _ -> stats
  }
}

fn team_compare(team1: Team, team2: Team) -> order.Order {
  case team1.1.points == team2.1.points {
    False -> int.compare(team2.1.points, team1.1.points)
    _ -> string.compare(team1.0, team2.0)
  }
}

fn to_string(teams: List(Team)) -> String {
  list.fold(teams, header, fn(acc, team) { acc <> team_to_string(team) })
}

fn team_to_string(team: Team) -> String {
  let #(name, stats) = team
  "\n"
  <> name |> string.pad_end(to: 30, with: " ")
  <> " |"
  <> stats.played |> int.to_string |> string.pad_start(to: 3, with: " ")
  <> " |"
  <> stats.won |> int.to_string |> string.pad_start(to: 3, with: " ")
  <> " |"
  <> stats.drawn |> int.to_string |> string.pad_start(to: 3, with: " ")
  <> " |"
  <> stats.lost |> int.to_string |> string.pad_start(to: 3, with: " ")
  <> " |"
  <> stats.points |> int.to_string |> string.pad_start(to: 3, with: " ")
}
