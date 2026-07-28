package chessboard

// Declare a type named File which stores if a square is occupied by a piece - this will be a slice of bools
type File []bool

// Declare a type named Chessboard which contains a map of eight Files, accessed with keys from "A" to "H"
type Chessboard map[string]File

// CountInFile returns how many squares are occupied in the chessboard,
// within the given file.
func CountInFile(cb Chessboard, file string) int {
	var total int
	for _, v := range cb[file] {
		if v {
			total++
		}
	}
	return total
}

// CountInRank returns how many squares are occupied in the chessboard,
// within the given rank.
func CountInRank(cb Chessboard, rank int) int {
	var total int
	for _, f := range cb {
		if rank > 0 && rank <= len(f) && f[rank-1] {
			total++
		}
	}
	return total

}

// CountAll should count how many squares are present in the chessboard.
func CountAll(cb Chessboard) int {
	var total int
	for _, f := range cb {
		total += len(f)
	}
	return total
}

// CountOccupied returns how many squares are occupied in the chessboard.
func CountOccupied(cb Chessboard) int {
	var total int
	for f, _ := range cb {
		total += CountInFile(cb, f)
	}
	return total
}
