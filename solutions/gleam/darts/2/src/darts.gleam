/// Much easier without float module for square_root and power
pub fn score(x: Float, y: Float) -> Int {
  case x *. x +. y *. y {
    r if r <=. 1.0 -> 10
    r if r <=. 25.0 -> 5
    r if r <=. 100.0 -> 1
    _ -> 0
  }
}
// pub fn score(x: Float, y: Float) -> Int {
//   case radius(x, y) {
//     r if r <=. 1.0 -> 10
//     r if r <=. 5.0 -> 5
//     r if r <=. 10.0 -> 1
//     _ -> 0
//   }
// }

// fn radius(x: Float, y: Float) -> Float {
//   let assert Ok(x_2) = float.power(x, 2.0)
//   let assert Ok(y_2) = float.power(y, 2.0)
//   let assert Ok(r) = float.square_root(x_2 +. y_2)
//   r
// }
