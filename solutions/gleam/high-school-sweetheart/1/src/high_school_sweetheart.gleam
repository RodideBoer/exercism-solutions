import gleam/list
import gleam/string

pub fn first_letter(name: String) {
  name
  |> string.trim_start()
  |> string.slice(at_index: 0, length: 1)
}

pub fn initial(name: String) {
  name
  |> first_letter()
  |> string.uppercase()
  <> "."
}

pub fn initials(full_name: String) {
  full_name
  |> string.trim
  |> string.split(on: " ")
  |> list.map(with: fn(name) { initial(name) })
  |> string.join(with: " ")
}

pub fn pair(full_name1: String, full_name2: String) {
  "
     ******       ******
   **      **   **      **
 **         ** **         **
**            *            **
**                         **
**     " <> initials(full_name1) <> "  +  " <> initials(full_name2) <> "     **
 **                       **
   **                   **
     **               **
       **           **
         **       **
           **   **
             ***
              *
"
}
