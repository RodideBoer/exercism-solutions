import gleam/int
import gleam/option.{type Option, None, Some}

pub type Player {
  Player(name: Option(String), level: Int, health: Int, mana: Option(Int))
}

pub fn introduce(player: Player) -> String {
  case player.name {
    Some(n) -> n
    None -> "Mighty Magician"
  }
}

pub fn revive(player: Player) -> Option(Player) {
  case player {
    Player(health: h, ..) if h > 0 -> None
    Player(level: l, ..) if l >= 10 ->
      Some(Player(..player, health: 100, mana: Some(100)))
    _ -> Some(Player(..player, health: 100))
  }
}

pub fn cast_spell(player: Player, cost: Int) -> #(Player, Int) {
  case player {
    Player(health: h, mana: None, ..) -> #(
      Player(..player, health: int.max(0, h - cost)),
      0,
    )
    Player(mana: Some(m), ..) if m >= cost -> #(
      Player(..player, mana: Some(m - cost)),
      cost * 2,
    )
    _ -> #(player, 0)
  }
}
