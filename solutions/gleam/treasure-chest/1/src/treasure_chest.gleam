pub type TreasureChest(a) {
  TreasureChest(password: String, value: a)
}

pub type UnlockResult(a) {
  Unlocked(a)
  WrongPassword
}

pub fn get_treasure(
  chest: TreasureChest(treasure),
  password: String,
) -> UnlockResult(treasure) {
  case chest.password == password {
    True -> Unlocked(chest.value)
    _ -> WrongPassword
  }
}
