import gleam/list
import gleam/result
import gleam/string

pub fn to_rna(dna: String) -> Result(String, Nil) {
  dna
  |> string.to_graphemes()
  |> list.try_map(nucleotide_to_rna)
  |> result.map(string.concat)
}

fn nucleotide_to_rna(dna_nucleotide: String) -> Result(String, Nil) {
  case dna_nucleotide {
    "G" -> Ok("C")
    "C" -> Ok("G")
    "T" -> Ok("A")
    "A" -> Ok("U")
    _ -> Error(Nil)
  }
}
