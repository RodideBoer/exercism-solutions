pub fn square_of_sum(n: Int) -> Int {
  let sum = sum_loop(n, 0, fn(i) { i })
  sum * sum
}

pub fn sum_of_squares(n: Int) -> Int {
  sum_loop(n, 0, fn(i) { i * i })
}

pub fn difference(n: Int) -> Int {
  square_of_sum(n) - sum_of_squares(n)
}

fn sum_loop(n: Int, acc: Int, func: fn(Int) -> Int) -> Int {
  case n {
    0 -> acc
    _ -> sum_loop(n - 1, acc + func(n), func)
  }
}
