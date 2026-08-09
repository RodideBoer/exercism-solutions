package parsinglogfiles

import (
	"fmt"
	"regexp"
)

func IsValidLine(text string) bool {
	re := regexp.MustCompile(`^\[(TRC|DBG|INF|WRN|ERR|FTL)\]`)
	return re.MatchString(text)
}

func SplitLogLine(text string) []string {
	re := regexp.MustCompile(`<[~\*=-]*>`)
	return re.Split(text, -1)
}

func CountQuotedPasswords(lines []string) int {
	var count int
	re := regexp.MustCompile(`".*(?i:password).*"`)
	for _, text := range lines {
		if re.MatchString(text) {
			count++
		}
	}
	return count
}

func RemoveEndOfLineText(text string) string {
	re := regexp.MustCompile(`end-of-line\d+`)
	return re.ReplaceAllString(text, "")
}

func TagWithUserName(lines []string) []string {
	re := regexp.MustCompile(`User[ ]+(\S+)`)
	output := make([]string, len(lines))
	for i, text := range lines {
		matches := re.FindStringSubmatch(text)
		if matches != nil {
			text = fmt.Sprintf("[USR] %s %s", matches[1], text)
		}
		output[i] = text
	}
	return output
}
