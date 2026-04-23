import gleam/string

type Numeral {
  Numeral(one: String, five: String)
}

pub fn convert(number: Int) -> String {
  convert_loop(number, 0, "")
}

fn convert_loop(number: Int, level: Int, acc: String) -> String {
  case level {
    3 -> digit(number, level) <> acc
    l -> convert_loop(number / 10, l + 1, digit(number % 10, l) <> acc)
  }
}

fn digit(digit: Int, level: Int) -> String {
  case digit, level {
    d, l if d < 4 -> string.repeat(numeral(l).one, d)
    4, l -> numeral(l).one <> numeral(l).five
    5, l -> numeral(l).five
    d, l if d < 9 -> numeral(l).five <> string.repeat(numeral(l).one, d - 5)
    9, l -> numeral(l).one <> numeral(l + 1).one
    _, _ -> ""
  }
}

fn numeral(level: Int) -> Numeral {
  case level {
    0 -> Numeral(one: "I", five: "V")
    1 -> Numeral(one: "X", five: "L")
    2 -> Numeral(one: "C", five: "D")
    3 -> Numeral(one: "M", five: "")
    _ -> Numeral(one: "", five: "")
  }
}
