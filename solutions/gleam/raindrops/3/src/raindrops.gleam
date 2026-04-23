import gleam/int
import gleam/string

pub fn convert(number: Int) -> String {
  let output =
    ""
    |> raindrop_loop(number, 3, "Pling")
    |> raindrop_loop(number, 5, "Plang")
    |> raindrop_loop(number, 7, "Plong")
  case string.is_empty(output) {
    True -> int.to_string(number)
    False -> output
  }
}

fn raindrop_loop(acc: String, number: Int, div: Int, output: String) -> String {
  case number % div {
    0 -> acc <> output
    _ -> acc
  }
}
//
// The following is using concatenation in stead of pipes.
// I think pipes and using a private 'loop' function with an accumulator is more idiomatic
// but I'm just a beginner in Gleam, so who knows.
//
// pub fn convert(number: Int) -> String {
//   let output =
//     raindrop(number, 3, "Pling")
//     <> raindrop(number, 5, "Plang")
//     <> raindrop(number, 7, "Plong")
//   case string.is_empty(output) {
//     True -> int.to_string(number)
//     False -> output
//   }
// }

// fn raindrop(number: Int, div: Int, output: String) -> String {
//   case number % div {
//     0 -> output
//     _ -> ""
//   }
// }
