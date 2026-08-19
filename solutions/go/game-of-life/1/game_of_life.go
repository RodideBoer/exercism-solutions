package gameoflife

func Tick(matrix [][]int) [][]int {
	out := make([][]int, len(matrix))
	for i := 0; i < len(matrix); i++ {
		out[i] = make([]int, len(matrix[i]))
		for j := 0; j < len(matrix[i]); j++ {
			count := countNeighbours(matrix, i, j)
			if matrix[i][j] == 1 && count >= 2 && count <= 3 {
				out[i][j] = 1
				continue
			}
			if matrix[i][j] == 0 && count == 3 {
				out[i][j] = 1
				continue
			}
			out[i][j] = 0
		}
	}
	return out
}

func countNeighbours(matrix [][]int, i, j int) int {
	return getCoord(matrix, i-1, j-1) +
		getCoord(matrix, i-1, j) +
		getCoord(matrix, i-1, j+1) +
		getCoord(matrix, i, j-1) +
		getCoord(matrix, i, j+1) +
		getCoord(matrix, i+1, j-1) +
		getCoord(matrix, i+1, j) +
		getCoord(matrix, i+1, j+1)

}

func getCoord(matrix [][]int, i, j int) int {
	if i < 0 || i >= len(matrix) || j < 0 || j >= len(matrix[0]) {
		return 0
	}
	return matrix[i][j]
}
