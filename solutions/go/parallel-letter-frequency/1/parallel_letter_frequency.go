package parallelletterfrequency

import (
	"regexp"
	"strings"
	"sync"
)

// FreqMap records the frequency of each rune in a given text.
type FreqMap map[rune]int

// Frequency counts the frequency of each rune in a given text and returns this
// data as a FreqMap.
func Frequency(text string) FreqMap {
	re := regexp.MustCompile(`[^\pL]`)
	text = re.ReplaceAllString(strings.ToLower(text), "")
	out := make(FreqMap)
	for _, r := range text {
		out[r]++
	}
	return out
}

// ConcurrentFrequency counts the frequency of each rune in the given strings,
// by making use of concurrency.
func ConcurrentFrequency(texts []string) FreqMap {
	count := len(texts)
	ch := make(chan FreqMap, count)
	var wg sync.WaitGroup
	wg.Add(count)
	for _, text := range texts {
		go func() {
			defer wg.Done()
			ch <- Frequency(text)
		}()
	}
	go func() {
		wg.Wait()
		close(ch)
	}()

	out := make(FreqMap)
	for f := range ch {
		for k, v := range f {
			out[k] += v
		}
	}
	return out
}
