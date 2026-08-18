package wordcount

import (
	"regexp"
	"strings"
)

type Frequency map[string]int

func WordCount(phrase string) Frequency {
	freq := make(Frequency)
	r := regexp.MustCompile(`([0-9a-zA-Z]+('[0-9a-zA-Z]+)*)`)
	words := r.FindAllString(strings.ToLower(phrase), -1)
	for _, w := range words {
		freq[w]++
	}
	return freq
}
