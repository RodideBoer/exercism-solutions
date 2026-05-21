import gleam/int
import gleam/list
import gleam/order
import gleam/string

type Team {
  Team(name: String, played: Int, won: Int, drawn: Int, lost: Int, points: Int)
}

fn create_team(name: String) -> Team {
  Team(name, 0, 0, 0, 0, 0)
}

pub fn tally(input: String) -> String {
  input
  |> string.split(on: "\n")
  |> parse_lines([])
  |> list.sort(by: team_compare)
  |> to_table
}

fn team_compare(team1: Team, team2: Team) -> order.Order {
  case team1.points == team2.points {
    False -> int.compare(team2.points, team1.points)
    _ -> string.compare(team1.name, team2.name)
  }
}

fn parse_lines(lines: List(String), teams: List(Team)) -> List(Team) {
  case lines {
    [] -> teams
    [line, ..rest] -> parse_lines(rest, parse_line(line, teams))
  }
}

fn parse_line(line: String, teams: List(Team)) -> List(Team) {
  case line |> string.split(on: ";") |> list.map(with: string.trim) {
    [team1, team2, result] -> add_result(teams, team1, team2, result)
    _ -> teams
  }
}

fn add_result(
  teams: List(Team),
  name1: String,
  name2: String,
  result: String,
) -> List(Team) {
  teams
  |> ensure_team(name1)
  |> ensure_team(name2)
  |> update_team(name1, result)
  |> update_team(name2, reverse_result(result))
}

fn reverse_result(result: String) -> String {
  case result {
    "win" -> "loss"
    "loss" -> "win"
    _ -> result
  }
}

fn update_team(teams: List(Team), name: String, result: String) -> List(Team) {
  use team <- list.map(teams)
  case team.name == name {
    False -> team
    True -> {
      let Team(_name, played, won, drawn, lost, points) = team
      case result {
        "win" ->
          Team(..team, played: played + 1, won: won + 1, points: points + 3)
        "draw" ->
          Team(..team, played: played + 1, drawn: drawn + 1, points: points + 1)
        "loss" -> Team(..team, played: played + 1, lost: lost + 1)
        _ -> team
      }
    }
  }
}

fn ensure_team(teams: List(Team), name: String) -> List(Team) {
  case teams |> list.any(satisfying: fn(team) { team.name == name }) {
    True -> teams
    False -> [create_team(name), ..teams]
  }
}

fn to_table(teams: List(Team)) -> String {
  header()
  <> teams
  |> list.map(team_to_string)
  |> string.concat
}

fn header() -> String {
  "Team                           | MP |  W |  D |  L |  P"
}

fn team_to_string(team: Team) -> String {
  "\n"
  <> team.name |> string.pad_end(to: 30, with: " ")
  <> " |"
  <> team.played |> int.to_string |> string.pad_start(to: 3, with: " ")
  <> " |"
  <> team.won |> int.to_string |> string.pad_start(to: 3, with: " ")
  <> " |"
  <> team.drawn |> int.to_string |> string.pad_start(to: 3, with: " ")
  <> " |"
  <> team.lost |> int.to_string |> string.pad_start(to: 3, with: " ")
  <> " |"
  <> team.points |> int.to_string |> string.pad_start(to: 3, with: " ")
}
