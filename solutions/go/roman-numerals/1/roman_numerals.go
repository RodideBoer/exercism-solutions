package romannumerals

import "errors"

type RomanNumeral struct {
	number int
	letter string
}

var mapping = []RomanNumeral{
	{1000, "M"},
	{900, "CM"},
	{500, "D"},
	{400, "CD"},
	{100, "C"},
	{90, "XC"},
	{50, "L"},
	{40, "XL"},
	{10, "X"},
	{9, "IX"},
	{5, "V"},
	{4, "IV"},
	{1, "I"},
}

func ToRomanNumeral(input int) (string, error) {
	var output string
	if input >= 4000 || input <= 0 {
		return output, errors.New("Invalid input")
	}
	for _, r := range mapping {
		for r.number <= input {
			output += r.letter
			input -= r.number
		}
	}
	return output, nil
}
