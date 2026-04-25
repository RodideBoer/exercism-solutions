import gleam/float
import gleam/list
import gleam/order.{type Order}

pub type City {
  City(name: String, temperature: Temperature)
}

pub type Temperature {
  Celsius(Float)
  Fahrenheit(Float)
}

pub fn fahrenheit_to_celsius(f: Float) -> Float {
  { f -. 32.0 } /. 1.8
}

pub fn compare_temperature(left: Temperature, right: Temperature) -> Order {
  case left, right {
    Celsius(l), Celsius(r) -> float.compare(l, r)
    Fahrenheit(l), Celsius(r) -> fahrenheit_to_celsius(l) |> float.compare(r)
    Celsius(l), Fahrenheit(r) -> fahrenheit_to_celsius(r) |> float.compare(l, _)
    Fahrenheit(l), Fahrenheit(r) -> float.compare(l, r)
  }
}

pub fn sort_cities_by_temperature(cities: List(City)) -> List(City) {
  list.sort(cities, by: fn(left, right) {
    compare_temperature(left.temperature, right.temperature)
  })
}
