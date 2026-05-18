import gleam/list

pub fn keep(list: List(t), predicate: fn(t) -> Bool) -> List(t) {
  filter_loop(list, [], predicate)
}

pub fn discard(list: List(t), predicate: fn(t) -> Bool) -> List(t) {
  keep(list, fn(value) { !predicate(value) })
}

fn filter_loop(
  list: List(t),
  acc: List(t),
  predicate: fn(t) -> Bool,
) -> List(t) {
  case list {
    [] -> list.reverse(acc)
    [head, ..tail] -> {
      case predicate(head) {
        False -> filter_loop(tail, acc, predicate)
        True -> filter_loop(tail, [head, ..acc], predicate)
      }
    }
  }
}
