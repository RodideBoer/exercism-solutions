import gleam/int
import gleam/string

pub fn convert(number: Int) -> String {
  let output =
    raindrop(number, 3, "Pling")
    <> raindrop(number, 5, "Plang")
    <> raindrop(number, 7, "Plong")
  case string.is_empty(output) {
    True -> int.to_string(number)
    False -> output
  }
}

fn raindrop(number: Int, div: Int, output: String) -> String {
  case number % div {
    0 -> output
    _ -> ""
  }
}
