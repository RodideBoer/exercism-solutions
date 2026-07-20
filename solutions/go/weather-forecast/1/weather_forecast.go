// Package weather allows you to get forecasts.
package weather

var (
    // CurrentCondition is a string.
	CurrentCondition string
    // CurrentLocation is a string.
	CurrentLocation  string
)

// Forecast will returns the forecast for a given city and condition.
func Forecast(city, condition string) string {
	CurrentLocation, CurrentCondition = city, condition
	return CurrentLocation + " - current weather condition: " + CurrentCondition
}
