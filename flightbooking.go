package main

import "net/http"

type flightId string

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
	http.HandleFunc("/v1/flight/flights", fetchFlights)
	return
}
