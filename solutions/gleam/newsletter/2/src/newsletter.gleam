import gleam/list
import gleam/result
import gleam/string
import simplifile

pub fn read_emails(path: String) -> Result(List(String), Nil) {
  // doing map twice is better than what I had before with an anonymous
  // function that does multiple things
  path
  |> simplifile.read()
  |> result.map(string.split(_, on: "\n"))
  |> result.map(list.filter(_, fn(email) { email != "" }))
  |> result.replace_error(Nil)
}

pub fn create_log_file(path: String) -> Result(Nil, Nil) {
  path
  |> simplifile.create_file()
  |> result.replace_error(Nil)
}

pub fn log_sent_email(path: String, email: String) -> Result(Nil, Nil) {
  // a bit cleaner than before and more in the same style
  email
  |> string.append("\n")
  |> simplifile.append(to: path)
  |> result.replace_error(Nil)
}

pub fn send_newsletter(
  emails_path: String,
  log_path: String,
  send_email: fn(String) -> Result(Nil, Nil),
) -> Result(Nil, Nil) {
  // try_each is way better then what I had before
  // together with this clean case
  // but we need to return Ok or else the iteration stops early
  use _ <- result.try(create_log_file(log_path))
  use emails <- result.try(read_emails(emails_path))
  use email <- list.try_each(emails)
  case send_email(email) {
    Ok(_) -> log_sent_email(log_path, email)
    Error(_) -> Ok(Nil)
  }
}
