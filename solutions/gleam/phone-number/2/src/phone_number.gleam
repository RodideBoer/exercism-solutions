import gleam/list
import gleam/result
import gleam/string

// Just a little cleaner and good enough
pub fn clean(input: String) -> Result(String, String) {
  Ok(input)
  |> result.map(remove_valid)
  |> result.try(check_letters)
  |> result.try(check_punctuation)
  |> result.try(check_length)
  |> result.try(check_and_remove_country)
  |> result.try(check_area)
  |> result.try(check_exchange)
}

fn remove_valid(input: String) -> String {
  input
  |> string.replace(" ", "")
  |> string.replace("(", "")
  |> string.replace(")", "")
  |> string.replace("-", "")
  |> string.replace(".", "")
  |> remove_country_plus()
}

fn remove_country_plus(input: String) -> String {
  case input {
    "+" <> rest -> rest
    _ -> input
  }
}

fn check_length(input: String) -> Result(String, String) {
  case string.length(input) {
    length if length > 11 -> Error("must not be greater than 11 digits")
    length if length < 10 -> Error("must not be fewer than 10 digits")
    _ -> Ok(input)
  }
}

fn check_and_remove_country(input: String) -> Result(String, String) {
  case input, string.length(input) {
    "1" <> _, 11 -> Ok(string.drop_start(input, 1))
    _, 11 -> Error("11 digits must start with 1")
    _, _ -> Ok(input)
  }
}

fn check_area(input: String) -> Result(String, String) {
  let first_of_area = input |> string.first()
  case first_of_area {
    Ok("0") -> Error("area code cannot start with zero")
    Ok("1") -> Error("area code cannot start with one")
    _ -> Ok(input)
  }
}

fn check_exchange(input: String) -> Result(String, String) {
  let first_of_exchange = input |> string.drop_start(3) |> string.first()
  case first_of_exchange {
    Ok("0") -> Error("exchange code cannot start with zero")
    Ok("1") -> Error("exchange code cannot start with one")
    _ -> Ok(input)
  }
}

fn check_punctuation(input: String) -> Result(String, String) {
  let punctuation = "@:!"
  let has_punctuation =
    list.any(string.to_graphemes(input), fn(char) {
      string.contains(punctuation, char)
    })
  case has_punctuation {
    True -> Error("punctuations not permitted")
    _ -> Ok(input)
  }
}

fn check_letters(input: String) -> Result(String, String) {
  let letters = "abcdefghijklmnopqrstuvwxyz"
  let has_letters =
    list.any(string.to_graphemes(input), fn(char) {
      string.contains(letters, char)
    })
  case has_letters {
    True -> Error("letters not permitted")
    _ -> Ok(input)
  }
}
