import gleam/list

pub type Pizza {
  Margherita
  Caprese
  Formaggio
  ExtraSauce(pizza: Pizza)
  ExtraToppings(pizza: Pizza)
}

pub fn pizza_price(pizza: Pizza) -> Int {
  pizza_price_loop(pizza, 0)
}

fn pizza_price_loop(pizza: Pizza, acc: Int) -> Int {
  case pizza {
    Margherita -> acc + 7
    Caprese -> acc + 9
    Formaggio -> acc + 10
    ExtraSauce(p) -> pizza_price_loop(p, acc + 1)
    ExtraToppings(p) -> pizza_price_loop(p, acc + 2)
  }
}

pub fn order_price(order: List(Pizza)) -> Int {
  let fee = case list.length(order) {
    2 -> 2
    1 -> 3
    _ -> 0
  }
  order_price_loop(order, fee)
}

fn order_price_loop(order: List(Pizza), acc: Int) -> Int {
  case order {
    [] -> acc
    [p, ..rest] -> order_price_loop(rest, acc + pizza_price(p))
  }
}
