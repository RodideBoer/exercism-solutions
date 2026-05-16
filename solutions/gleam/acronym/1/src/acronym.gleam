import gleam/list
import gleam/result
import gleam/string

pub fn abbreviate(phrase phrase: String) -> String {
  phrase
  |> remove_punctuation(["_"])
  |> string.split(" ")
  |> list.flat_map(string.split(_, "-"))
  |> list.filter(fn(s) { string.trim(s) != "" })
  |> list.try_map(fn(s) { s |> string.uppercase() |> string.first() })
  |> result.unwrap([])
  |> string.concat()
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
