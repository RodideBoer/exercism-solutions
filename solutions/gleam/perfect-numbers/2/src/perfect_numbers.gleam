import gleam/bool
import gleam/int
import gleam/list
import gleam/order

pub type Classification {
  Perfect
  Abundant
  Deficient
}

pub type Error {
  NonPositiveInt
}

// Much cleaner solution than my first iteration
// I must remember to use bool.guard!

pub fn classify(number: Int) -> Result(Classification, Error) {
  use <- bool.guard(when: number <= 0, return: Error(NonPositiveInt))
  case int.compare(aliquot_sum(number), number) {
    order.Gt -> Ok(Abundant)
    order.Lt -> Ok(Deficient)
    _ -> Ok(Perfect)
  }
}

fn aliquot_sum(number: Int) -> Int {
  list.range(from: 0, to: number / 2)
  |> list.filter(keeping: fn(n) { number % n == 0 })
  |> int.sum()
}
