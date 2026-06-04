import gleam/int
import gleam/order

pub type Classification {
  Perfect
  Abundant
  Deficient
}

pub type Error {
  NonPositiveInt
}

pub fn classify(number: Int) -> Result(Classification, Error) {
  case number < 1 {
    True -> Error(NonPositiveInt)
    False -> Ok(to_classification(number, sum_of_factors(number, 0, 1)))
  }
}

fn to_classification(number: Int, sum: Int) -> Classification {
  case int.compare(number, sum) {
    order.Lt -> Abundant
    order.Gt -> Deficient
    _ -> Perfect
  }
}

fn sum_of_factors(number: Int, sum: Int, current: Int) -> Int {
  case current > number / 2 {
    True -> sum
    _ -> {
      case number % current == 0 {
        True -> sum_of_factors(number, sum + current, current + 1)
        _ -> sum_of_factors(number, sum, current + 1)
      }
    }
  }
}
