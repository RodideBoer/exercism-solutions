// Using my own recursive sum function

pub fn square_of_sum(n: Int) -> Int {
  let sum = sum_loop(n, 0, fn(i) { i })
  sum * sum
}

pub fn sum_of_squares(n: Int) -> Int {
  sum_loop(n, 0, fn(i) { i * i })
}

fn sum_loop(n: Int, acc: Int, func: fn(Int) -> Int) -> Int {
  case n {
    0 -> acc
    _ -> sum_loop(n - 1, acc + func(n), func)
  }
}

pub fn difference(n: Int) -> Int {
  square_of_sum(n) - sum_of_squares(n)
}
// Using list.range, which should be int.range in newer versions of stdlib

// import gleam/int
// import gleam/list

// pub fn square_of_sum(n: Int) -> Int {
//   let sum =
//     list.range(1, n)
//     |> int.sum
//   //or with fold: |> list.fold(0, int.add)
//   sum * sum
// }

// pub fn sum_of_squares(n: Int) -> Int {
//   list.range(1, n)
//   |> list.fold(0, fn(acc, x) { acc + x * x })
// }

// Optimized algorithm

// pub fn square_of_sum(n: Int) -> Int {
//   let sum = n * { n + 1 } / 2
//   sum * sum
// }

// pub fn sum_of_squares(n: Int) -> Int {
//   n * { n + 1 } * { 2 * n + 1 } / 6
// }
