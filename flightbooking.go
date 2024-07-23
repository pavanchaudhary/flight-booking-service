package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strconv"
	"strings"
)

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

type FlightResponses struct {
	FlightsList []FlightResponse `json:"flightsList"`
}

func fetchFlights(w http.ResponseWriter, r *http.Request) {
	//Parse request params for flight request details
	rq := r.URL.Query()
	f := &FlightRequest{}
	f.Origin = GetAirportCode(rq["origin"][0])
	f.Destination = GetAirportCode(rq["destination"][0])
	stops, _ := strconv.Atoi(rq["stops"][0])
	f.Stops = uint8(stops)
	f.Class = flightClass(strings.ToLower(rq["class"][0]))
	f.FlightDate = flightDate(rq["date"][0])

	//Query the DB
	db := GetMysqlConn()
	var flightQuery string
	if f.Class == economy {
		flightQuery = fmt.Sprintf("SELECT flight.FlightId, flight.Departure, flight.Arrival FROM flight INNER JOIN flightSeatAvailability ON flight.FlightId = flightSeatAvailability.FlightId WHERE flightSeatAvailability.FlightDate = '%s' AND flight.Origin = '%s' AND flight.Destination = '%s' AND flight.NumberOfStops = %d AND flight.EconomyClassAvailable = %t;", f.FlightDate, f.Origin, f.Destination, f.Stops, true)
	} else {
		flightQuery = fmt.Sprintf("SELECT flight.FlightId, flight.Departure, flight.Arrival FROM flight INNER JOIN flightSeatAvailability ON flight.FlightId = flightSeatAvailability.FlightId WHERE flightSeatAvailability.FlightDate = '%s' AND flight.Origin = '%s' AND flight.Destination = '%s' AND flight.NumberOfStops = %d AND flight.BusinessClassAvailable = %t;", f.FlightDate, f.Origin, f.Destination, f.Stops, true)
	}
	rows, err := db.Query(flightQuery)
	if err != nil {
		http.Error(w, "Internal error", 342)
	}
	defer rows.Close()
	//Scan and append the responses
	var fr []FlightResponse
	for rows.Next() {
		var f FlightResponse
		if err := rows.Scan(&f.FlightId, &f.Departure, &f.Arrival); err != nil {
			http.Error(w, "sql scan error", 324)
		}
		fr = append(fr, f)
	}
	var flightsList FlightResponses
	flightsList.FlightsList = fr

	//Send responses as json
	respData, err := json.Marshal(flightsList)
	if err != nil {
		fmt.Println("error marshalling JSON data")
	}
	w.Header().Set("Content-Type", "application/json")
	w.Write(respData)
}

func main() {
	setConfig()
	http.HandleFunc("/v1/flight/flights", fetchFlights)
	http.ListenAndServe("localhost:1729", nil)
}
