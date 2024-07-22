package main

type flightId string

type airportCode string

// const (
// 	AMD airportCode = "AMD",
// 	HYD airportCode = "HYD",
// 	BLR airportCode = "BLR",
// 	DEL airportCode = "DEL",
// 	BOM airportCode = "BOM",
// 	CCU airportCode = "CCU",
// )

type flightClass string

const (
	economy  flightClass = "economy"
	business flightClass = "business"
)

type flightDate string
type flightTime string

type FlightRequest struct {
	Origin      airportCode `json:"origin"`
	Destination airportCode `json:"destination"`
	Stops       uint8       `json:"stops"`
	Class       flightClass `json:"class"`
	FlightDate  flightDate  `json:"date"`
}

type FlightResponse struct {
	FlightId  flightId   `json:"flightId"`
	Departure flightTime `json:"departure"`
	Arrival   flightTime `json:"arrival"`
}

type FlightsResponse struct {
	FlightsList []FlightResponse `json:"flightsList"`
}

func main() {
	return
}
