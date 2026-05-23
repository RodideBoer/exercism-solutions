import gleam/bool
import gleam/list
import gleam/result

pub type Tree(a) {
  Tree(label: a, children: List(Tree(a)))
}

pub fn from_pov(tree: Tree(a), from: a) -> Result(Tree(a), Nil) {
  tree
  |> from_pov_loop(from, tree)
}

fn from_pov_loop(orig: Tree(a), find: a, new: Tree(a)) -> Result(Tree(a), Nil) {
  // Now using bool.guard
  use <- bool.guard(orig.label == find, Ok(new))
  list.fold(orig.children, Error(Nil), fn(acc, child) {
    result.or(acc, from_pov_loop(child, find, change_pov(from: new, to: child)))
  })
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
  // Now using bool.guard
  use <- bool.guard(tree.label == to, Ok(list.reverse(path)))
  list.fold(tree.children, Error(Nil), fn(acc, child) {
    result.or(acc, path_to_loop(child, to, [child.label, ..path]))
  })
}
