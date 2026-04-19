pub fn is_leap_year(year: Int) -> Bool {
  case year {
    x if x % 400 == 0 -> True
    x if x % 100 == 0 -> False
    x if x % 4 == 0 -> True
    _ -> False
  }
}
