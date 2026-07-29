package thefarm

import (
	"errors"
	"fmt"
)

func DivideFood(c FodderCalculator, cows int) (float64, error) {
	fodder, err := c.FodderAmount(cows)
	if err != nil {
		return 0, err
	}
	factor, err := c.FatteningFactor()
	if err != nil {
		return 0, err
	}
	return fodder / float64(cows) * factor, nil
}

func ValidateInputAndDivideFood(c FodderCalculator, cows int) (float64, error) {
	if cows > 0 {
		return DivideFood(c, cows)
	}
	return 0, errors.New("invalid number of cows")
}

type InvalidCowsError struct {
	cows    int
	message string
}

func (e InvalidCowsError) Error() string {
	return fmt.Sprintf("%d cows are invalid: %s", e.cows, e.message)
}

func ValidateNumberOfCows(cows int) error {
	if cows < 0 {
		return &InvalidCowsError{cows, "there are no negative cows"}
	}
	if cows == 0 {
		return &InvalidCowsError{cows, "no cows don't need food"}
	}
	return nil
}

// Your first steps could be to read through the tasks, and create
// these functions with their correct parameter lists and return types.
// The function body only needs to contain `panic("")`.
//
// This will make the tests compile, but they will fail.
// You can then implement the function logic one by one and see
// an increasing number of tests passing as you implement more
// functionality.
