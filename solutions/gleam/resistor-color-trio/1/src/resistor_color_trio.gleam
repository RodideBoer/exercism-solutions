import gleam/list

pub type Resistance {
  Resistance(unit: String, value: Int)
}

pub fn label(colors: List(String)) -> Result(Resistance, Nil) {
  case list.try_map(colors, code) {
    Ok([a, b, c, ..]) -> Ok(to_resistance(a, b, c))
    _ -> Error(Nil)
  }
}

fn to_resistance(a: Int, b: Int, c: Int) -> Resistance {
  //
  // Couldn't come up with a short and clean algorithm, so this is what it is.
  //
  // First 2 colors
  let value = a * 10 + b
  // Add zeros
  let value = case c % 3 {
    1 -> value * 10
    2 -> value * 100
    _ -> value
  }
  // If second color is zero we need to adjust for the extra zero
  let #(c, value) = case a, b {
    0, 0 -> #(0, value)
    _, 0 -> #(c + 1, value / 1000)
    _, _ -> #(c, value)
  }
  // Prefix
  let prefix = case c / 3 {
    1 -> "kilo"
    2 -> "mega"
    3 -> "giga"
    _ -> ""
  }
  Resistance(prefix <> "ohms", value)
}

fn code(color: String) -> Result(Int, Nil) {
  case color {
    "black" -> Ok(0)
    "brown" -> Ok(1)
    "red" -> Ok(2)
    "orange" -> Ok(3)
    "yellow" -> Ok(4)
    "green" -> Ok(5)
    "blue" -> Ok(6)
    "violet" -> Ok(7)
    "grey" -> Ok(8)
    "white" -> Ok(9)
    _ -> Error(Nil)
  }
}
