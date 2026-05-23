import gleam/list
import gleam/result

pub type Tree(a) {
  Tree(label: a, children: List(Tree(a)))
}

pub fn from_pov(tree: Tree(a), from: a) -> Result(Tree(a), Nil) {
  tree
  |> move_pov(from, tree)
}

fn move_pov(orig: Tree(a), find: a, new: Tree(a)) -> Result(Tree(a), Nil) {
  case orig.label == find {
    True -> Ok(new)
    False ->
      list.fold(orig.children, Error(Nil), fn(acc, child) {
        result.or(acc, move_pov(child, find, change_pov(from: new, to: child)))
      })
  }
}

fn change_pov(from parent: Tree(a), to child: Tree(a)) -> Tree(a) {
  let parent_as_child =
    Tree(parent.label, list.filter(parent.children, fn(tree) { tree != child }))
  Tree(child.label, [parent_as_child, ..child.children])
}

pub fn path_to(
  tree tree: Tree(a),
  from from: a,
  to to: a,
) -> Result(List(a), Nil) {
  tree
  |> from_pov(from)
  |> result.try(fn(pov) { path_to_loop(pov, to, [pov.label]) })
}

fn path_to_loop(tree: Tree(a), to: a, path: List(a)) -> Result(List(a), Nil) {
  case tree.label == to {
    True -> Ok(list.reverse(path))
    False ->
      list.fold(tree.children, Error(Nil), fn(acc, child) {
        result.or(acc, path_to_loop(child, to, [child.label, ..path]))
      })
  }
}
