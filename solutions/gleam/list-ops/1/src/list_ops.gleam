pub fn append(first first: List(a), second second: List(a)) -> List(a) {
  append_loop(reverse(first), second)
}

fn append_loop(first: List(a), acc: List(a)) -> List(a) {
  case first {
    [] -> acc
    [head, ..tail] -> append_loop(tail, [head, ..acc])
  }
}

pub fn concat(lists: List(List(a))) -> List(a) {
  foldl(lists, [], fn(b, a) { append(b, a) })
}

pub fn filter(list: List(a), function: fn(a) -> Bool) -> List(a) {
  filter_loop(list, [], function)
}

fn filter_loop(
  list: List(a),
  acc: List(a),
  predicate: fn(a) -> Bool,
) -> List(a) {
  case list {
    [] -> reverse(acc)
    [head, ..tail] -> {
      case predicate(head) {
        False -> filter_loop(tail, acc, predicate)
        True -> filter_loop(tail, [head, ..acc], predicate)
      }
    }
  }
}

pub fn length(list: List(a)) -> Int {
  length_loop(list, 0)
}

fn length_loop(list: List(a), acc: Int) -> Int {
  case list {
    [] -> acc
    [_, ..tail] -> length_loop(tail, acc + 1)
  }
}

pub fn map(list: List(a), function: fn(a) -> b) -> List(b) {
  map_loop(list, [], function)
}

fn map_loop(list: List(a), acc: List(b), function: fn(a) -> b) -> List(b) {
  case list {
    [] -> reverse(acc)
    [head, ..tail] -> map_loop(tail, [function(head), ..acc], function)
  }
}

pub fn foldl(
  over list: List(a),
  from initial: b,
  with function: fn(b, a) -> b,
) -> b {
  case list {
    [] -> initial
    [head, ..tail] -> foldl(tail, function(initial, head), function)
  }
}

pub fn foldr(
  over list: List(a),
  from initial: b,
  with function: fn(b, a) -> b,
) -> b {
  foldl(reverse(list), initial, function)
}

pub fn reverse(list: List(a)) -> List(a) {
  reverse_loop(list, [])
}

fn reverse_loop(list: List(a), acc: List(a)) -> List(a) {
  case list {
    [] -> acc
    [head, ..tail] -> reverse_loop(tail, [head, ..acc])
  }
}
