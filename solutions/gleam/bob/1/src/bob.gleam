import gleam/string

pub fn hey(remark: String) -> String {
  let remark = string.trim(remark)
  case is_question(remark), is_yell(remark), is_silence(remark) {
    _, _, True -> "Fine. Be that way!"
    True, True, _ -> "Calm down, I know what I'm doing!"
    True, False, _ -> "Sure."
    False, True, _ -> "Whoa, chill out!"
    _, _, _ -> "Whatever."
  }
}

fn is_question(remark: String) -> Bool {
  string.ends_with(remark, "?")
}

fn is_yell(remark: String) -> Bool {
  string.uppercase(remark) == remark && string.lowercase(remark) != remark
}

fn is_silence(remark: String) -> Bool {
  remark == ""
}
