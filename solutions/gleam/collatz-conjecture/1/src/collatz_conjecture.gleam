import gleam/bool
import gleam/int

pub type Error {
  NonPositiveNumber
}

pub fn steps(number: Int) -> Result(Int, Error) {
  use <- bool.guard(number < 1, Error(NonPositiveNumber))
  Ok(steps_loop(number, 0))
}

fn steps_loop(number: Int, count: Int) -> Int {
  case number {
    1 -> count
    _ -> {
      case int.is_odd(number) {
        True -> steps_loop(number * 3 + 1, count + 1)
        False -> steps_loop(number / 2, count + 1)
      }
    }
  }
}
