import gleam/list
import gleam/result

pub type Nucleotide {
  Adenine
  Cytosine
  Guanine
  Thymine
}

pub fn encode_nucleotide(nucleotide: Nucleotide) -> Int {
  case nucleotide {
    Adenine -> 0b00
    Cytosine -> 0b01
    Guanine -> 0b10
    Thymine -> 0b11
  }
}

pub fn decode_nucleotide(nucleotide: Int) -> Result(Nucleotide, Nil) {
  case nucleotide {
    0b00 -> Ok(Adenine)
    0b01 -> Ok(Cytosine)
    0b10 -> Ok(Guanine)
    0b11 -> Ok(Thymine)
    _ -> Error(Nil)
  }
}

pub fn encode(dna: List(Nucleotide)) -> BitArray {
  list.fold(dna, <<>>, fn(acc, nucleotide) {
    <<acc:bits, encode_nucleotide(nucleotide):2>>
  })
  // could also use the custom tail recursive loop function
  // encode_loop(dna, <<>>)
}

// tail recursive loop function
// fn encode_loop(dna: List(Nucleotide), acc: BitArray) -> BitArray {
//   case dna {
//     [] -> acc
//     [n, ..rest] -> encode_loop(rest, <<acc:bits, encode_nucleotide(n):2>>)
//   }
// }

pub fn decode(dna: BitArray) -> Result(List(Nucleotide), Nil) {
  case dna {
    <<>> -> Ok([])
    <<nucleotide:2, rest:bits>> -> {
      // after looking at some examples this looks cleaner, but is it more readable too?
      use head <- result.try(decode_nucleotide(nucleotide))
      use tail <- result.try(decode(rest))
      Ok([head, ..tail])
      // my own version:
      // case decode_nucleotide(nucleotide) {
      //   Ok(nucleotide) ->
      //     result.map(decode(rest), fn(nucleotides) {
      //       [nucleotide, ..nucleotides]
      //     })
      //   _ -> Error(Nil)
      // }
    }
    _ -> Error(Nil)
  }
  // could also use the custom tail recursive loop function
  // decode_loop(dna, [])
}
// tail recursive loop function; uses list.append; not sure this is a good solution
// fn decode_loop(
//   dna: BitArray,
//   acc: List(Nucleotide),
// ) -> Result(List(Nucleotide), Nil) {
//   case dna {
//     <<>> -> Ok(acc)
//     <<nucleotide:2, rest:bits>> -> {
//       case decode_nucleotide(nucleotide) {
//         Ok(nucleotide) -> decode_loop(rest, list.append(acc, [nucleotide]))
//         _ -> Error(Nil)
//       }
//     }
//     _ -> Error(Nil)
//   }
// }
