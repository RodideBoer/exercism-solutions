pub type Tree(a) {
  Leaf
  Node(value: a, left: Tree(a), right: Tree(a))
}

pub opaque type Zipper(a) {
  Zipper(focus: Tree(a), path: Path(a))
}

type Path(a) {
  Top
  Left(path: Path(a), value: a, right: Tree(a))
  Right(path: Path(a), value: a, left: Tree(a))
}

pub fn to_zipper(tree: Tree(a)) -> Zipper(a) {
  Zipper(tree, Top)
}

pub fn to_tree(zipper: Zipper(a)) -> Tree(a) {
  case up(zipper) {
    Ok(zipper) -> zipper |> to_tree
    _ -> zipper.focus
  }
}

pub fn value(zipper: Zipper(a)) -> Result(a, Nil) {
  case zipper.focus {
    Node(value: v, ..) -> Ok(v)
    _ -> Error(Nil)
  }
}

pub fn up(zipper: Zipper(a)) -> Result(Zipper(a), Nil) {
  case zipper.path {
    Left(path, value, right) ->
      Ok(Zipper(Node(value, zipper.focus, right), path))
    Right(path, value, left) ->
      Ok(Zipper(Node(value, left, zipper.focus), path))
    _ -> Error(Nil)
  }
}

pub fn left(zipper: Zipper(a)) -> Result(Zipper(a), Nil) {
  case zipper.focus {
    Node(value, left, right) ->
      Ok(Zipper(focus: left, path: Left(zipper.path, value, right)))
    _ -> Error(Nil)
  }
}

pub fn right(zipper: Zipper(a)) -> Result(Zipper(a), Nil) {
  case zipper.focus {
    Node(value, left, right) ->
      Ok(Zipper(focus: right, path: Right(zipper.path, value, left)))
    _ -> Error(Nil)
  }
}

pub fn set_value(zipper: Zipper(a), value: a) -> Zipper(a) {
  case zipper.focus {
    Node(_, left, right) -> Zipper(Node(value, left, right), zipper.path)
    Leaf -> Zipper(Node(value, Leaf, Leaf), zipper.path)
  }
}

pub fn set_left(zipper: Zipper(a), tree: Tree(a)) -> Result(Zipper(a), Nil) {
  case zipper.focus {
    Node(value, _, right) -> Ok(Zipper(Node(value, tree, right), zipper.path))
    _ -> Error(Nil)
  }
}

pub fn set_right(zipper: Zipper(a), tree: Tree(a)) -> Result(Zipper(a), Nil) {
  case zipper.focus {
    Node(value, left, _) -> Ok(Zipper(Node(value, left, tree), zipper.path))
    _ -> Error(Nil)
  }
}
