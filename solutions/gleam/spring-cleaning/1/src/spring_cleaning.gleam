import gleam/pair
import gleam/string

pub fn extract_error(problem: Result(a, b)) -> b {
  let assert Error(error) = problem
  error
}

pub fn remove_team_prefix(team: String) -> String {
  let assert "Team " <> name = team
  name
}

pub fn split_region_and_team(combined: String) -> #(String, String) {
  let assert Ok(split) = string.split_once(combined, on: ",")
  pair.map_second(split, remove_team_prefix)
  // Not a good use for use, but just to practive, how would it be
  // use team <- pair.map_second(split)
  // remove_team_prefix(team)
}
