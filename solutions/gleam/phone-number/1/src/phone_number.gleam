import gleam/list
import gleam/result
import gleam/string

const punctuation = ["@", ":", "!"]

const letters = [
  "a",
  "b",
  "c",
  "d",
  "e",
  "f",
  "g",
  "h",
  "i",
  "j",
  "k",
  "l",
  "m",
  "n",
  "o",
  "p",
  "q",
  "r",
  "s",
  "t",
  "u",
  "v",
  "w",
  "x",
  "y",
  "z",
]

pub fn clean(input: String) -> Result(String, String) {
  input
  |> check_punctuation()
  |> result.try(check_letters)
  |> result.map(string.to_graphemes)
  |> result.map(filter_digits)
  |> result.try(check_length)
  |> result.try(check_country)
  |> result.map(remove_country)
  |> result.try(check_area)
  |> result.try(check_exchange)
  |> result.map(string.concat)
}

fn filter_digits(input: List(String)) -> List(String) {
  input
  |> list.filter(is_digit)
}

fn remove_country(input: List(String)) -> List(String) {
  case list.length(input) {
    11 -> list.drop(input, 1)
    _ -> input
  }
}

fn check_length(input: List(String)) -> Result(List(String), String) {
  case list.length(input) {
    length if length > 11 -> Error("must not be greater than 11 digits")
    length if length < 10 -> Error("must not be fewer than 10 digits")
    _ -> Ok(input)
  }
}

fn check_country(input: List(String)) -> Result(List(String), String) {
  let country = result.unwrap(list.first(input), "")
  case country, list.length(input) {
    country, 11 if country != "1" -> Error("11 digits must start with 1")
    _, _ -> Ok(input)
  }
}

fn check_area(input: List(String)) -> Result(List(String), String) {
  let first_of_area = input |> list.first() |> result.unwrap("")
  case first_of_area {
    "0" -> Error("area code cannot start with zero")
    "1" -> Error("area code cannot start with one")
    _ -> Ok(input)
  }
}

fn check_exchange(input: List(String)) -> Result(List(String), String) {
  let first_of_exchange =
    input |> list.drop(3) |> list.first() |> result.unwrap("")
  case first_of_exchange {
    "0" -> Error("exchange code cannot start with zero")
    "1" -> Error("exchange code cannot start with one")
    _ -> Ok(input)
  }
}

fn check_punctuation(input: String) -> Result(String, String) {
  case contains_one_of_loop(input, punctuation) {
    True -> Error("punctuations not permitted")
    _ -> Ok(input)
  }
}

fn check_letters(input: String) -> Result(String, String) {
  case contains_one_of_loop(input, letters) {
    True -> Error("letters not permitted")
    _ -> Ok(input)
  }
}

fn contains_one_of_loop(input: String, contains chars: List(String)) -> Bool {
  case chars {
    [] -> False
    [char, ..rest] -> {
      case string.contains(input, char) {
        True -> True
        _ -> contains_one_of_loop(input, rest)
      }
    }
  }
}

fn is_digit(input: String) -> Bool {
  case input {
    "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" -> True
    _ -> False
  }
}
