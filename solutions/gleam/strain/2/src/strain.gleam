import gleam/list

pub fn keep(list: List(t), predicate: fn(t) -> Bool) -> List(t) {
  keep_loop(list, [], predicate)
}

pub fn discard(list: List(t), predicate: fn(t) -> Bool) -> List(t) {
  keep_loop(list, [], fn(value) { !predicate(value) })
}

pub fn keep_loop(
  list: List(t),
  acc: List(t),
  predicate: fn(t) -> Bool,
) -> List(t) {
  case list {
    [] -> list.reverse(acc)
    [head, ..tail] -> {
      case predicate(head) {
        False -> keep_loop(tail, acc, predicate)
        True -> keep_loop(tail, [head, ..acc], predicate)
      }
    }
  }
}
