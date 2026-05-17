import gleam/list
import gleam/result
import gleam/string

// not using regular expressions
pub fn abbreviate(phrase phrase: String) -> String {
  // no flat_map, no filter, no uppercase in map
  phrase
  |> remove_punctuation(["_"])
  |> string.replace("-", " ")
  |> string.split(" ")
  |> list.map(string.first)
  |> result.values()
  |> string.concat()
  |> string.uppercase()
}

fn remove_punctuation(
  in string: String,
  for punctuations: List(String),
) -> String {
  case punctuations {
    [] -> string
    [punc, ..tail] -> remove_punctuation(string.replace(string, punc, ""), tail)
  }
}
