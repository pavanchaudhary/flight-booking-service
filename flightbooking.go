package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"io"
	"log"
	"net/http"
	"strconv"
	"strings"
	"sync"
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
		log.Println("Query failed for fetching flights")
	}
	defer rows.Close()
	//Scan and append the responses
	var fr []FlightResponse
	for rows.Next() {
		var f FlightResponse
		if err := rows.Scan(&f.FlightId, &f.Departure, &f.Arrival); err != nil {
			log.Println("Error scanning db flight response")
		}
		fr = append(fr, f)
	}
	var flightsList FlightResponses
	flightsList.FlightsList = fr

	//Send responses as json
	respData, err := json.Marshal(flightsList)
	if err != nil {
		log.Println("Error marshalling flight response JSON")
	}
	w.Header().Set("Content-Type", "application/json")
	w.Write(respData)
}

type gender string

const (
	male   gender = "male"
	female gender = "female"
	others gender = "others"
)

type passenger struct {
	Age       int    `json:"age"`
	FirstName string `json:"firstname"`
	LastName  string `json:"lastname"`
	Email     string `json:"email"`
	Gender    gender `json:"gender"`
}

type FlightBookingRequest struct {
	FlightId       flightId    `json:"flightId"`
	Passengers     []passenger `json:"passengers"`
	FlightDate     flightDate  `json:"date"`
	Class          flightClass `json:"class"`
	SeatsAvailable int         `json:"seatsavailable`
}

type flightTerminal string

type FlightBookingReponse struct {
	Pnr              string         `json:"pnr"`
	Passengers       []passenger    `json:"passengers"`
	Origin           airportCode    `json:"origin"`
	Destination      airportCode    `json:"destination"`
	FlightDate       flightDate     `json:"date"`
	Class            flightClass    `json:"class"`
	Departure        flightTime     `json:"departure"`
	Arrival          flightTime     `json:"arrival"`
	DepatureTerminal flightTerminal `json:"departure_terminal"`
	ArrivalTerminal  flightTerminal `json:"arrival_terminal"`
}

func sendBookingDetails(w http.ResponseWriter, fbr *FlightBookingRequest, db *sql.DB, wg *sync.WaitGroup) {
	//TODO: Add logic for generating PNR
	//TODO: Add logic for assigning terminals and it's properties
	defer wg.Done()
	bookingResponse := FlightBookingReponse{
		Pnr:              "TXQ173",
		Passengers:       fbr.Passengers,
		Origin:           "",
		Destination:      "",
		FlightDate:       fbr.FlightDate,
		Class:            fbr.Class,
		Departure:        "",
		Arrival:          "",
		DepatureTerminal: "T1",
		ArrivalTerminal:  "T3",
	}
	rows, err := db.Query(fmt.Sprintf("SELECT flight.Origin, flight.Destination, flight.Departure, flight.Arrival FROM flight WHERE flightId = '%s'", fbr.FlightId))
	if err != nil {
		log.Println("Query failed for flight booking details")
	}
	defer rows.Close()
	for rows.Next() {
		if err := rows.Scan(&bookingResponse.Origin, &bookingResponse.Destination, &bookingResponse.Departure, &bookingResponse.Arrival); err != nil {
			log.Println("Error scanning db flight booking info")
		}
	}
	bookingResponseData, err := json.Marshal(bookingResponse)
	if err != nil {
		log.Println("Error marshalling booking response json")
	}
	w.Header().Set("Content-Type", "application/json")
	_, err = w.Write(bookingResponseData)
	if err != nil {
		log.Println("Error sending HTTP response")
	}
	//TO-DO: push the booking details to DB
}

// Lock for booking seats.
var queryLock *sync.Mutex = &sync.Mutex{}

func bookFlights(w http.ResponseWriter, r *http.Request) {
	var fbr FlightBookingRequest
	reqbody, err := io.ReadAll(r.Body)
	if err != nil {
		log.Println("Failed to read http body for flight booking")
	}

	json.Unmarshal(reqbody, &fbr)
	if err != nil {
		log.Println("json unmarshalling failed for flight booking")
	}
	// Lock to prevent the http handler function return until go routines completes
	// and no unnecessarily locking
	wg := &sync.WaitGroup{}
	db := GetMysqlConn()
	if fbr.Class == economy {
		//Lock the update seat query
		queryLock.Lock()
		rows, err := db.Query(fmt.Sprintf("SELECT flightSeatAvailability.SeatsAvailableEconomy FROM flight INNER JOIN flightSeatAvailability ON flight.FlightId = flightSeatAvailability.FlightId WHERE flightSeatAvailability.FlightDate = '%s' AND flight.EconomyClassAvailable = %t", fbr.FlightDate, true))
		if err != nil {
			log.Println("Query failed for flight booking details")
		}
		defer rows.Close()
		for rows.Next() {
			if err := rows.Scan(&fbr.SeatsAvailable); err != nil {
				log.Println("Error scanning db flight booking response")
			}
		}
		if fbr.SeatsAvailable > len(fbr.Passengers) {
			_, err = db.Query(fmt.Sprintf("UPDATE flightSeatAvailability SET SeatsAvailableEconomy = %d WHERE FlightId = '%s' AND FlightDate = '%s'", fbr.SeatsAvailable-len(fbr.Passengers), fbr.FlightId, fbr.FlightDate))
			if err != nil {
				log.Println("Update Query failed for flight booking")
			}
			wg.Add(1)
			go sendBookingDetails(w, &fbr, db, wg)
		}
		queryLock.Unlock()
	} else {
		//Lock the update seat query
		queryLock.Lock()
		rows, err := db.Query(fmt.Sprintf("SELECT flightSeatAvailability.SeatsAvailableBusiness FROM flight INNER JOIN flightSeatAvailability ON flight.FlightId = flightSeatAvailability.FlightId WHERE flightSeatAvailability.FlightDate = '%s' AND flight.BusinessClassAvailable = %t", fbr.FlightDate, true))
		if err != nil {
			log.Println("Query failed for flight booking details")
		}
		defer rows.Close()
		for rows.Next() {
			if err := rows.Scan(&fbr.SeatsAvailable); err != nil {
				log.Println("Error scanning db flight booking response")
			}
		}
		if fbr.SeatsAvailable > len(fbr.Passengers) {
			_, err = db.Query(fmt.Sprintf("UPDATE flightSeatAvailability SET SeatsAvailableBusiness = %d WHERE FlightId = '%s' AND FlightDate = '%s'", fbr.SeatsAvailable-len(fbr.Passengers), fbr.FlightId, fbr.FlightDate))
			if err != nil {
				log.Println("Update Query failed for flight booking")
			}
			wg.Add(1)
			go sendBookingDetails(w, &fbr, db, wg)
		}
		queryLock.Unlock()
	}
	wg.Wait()
}

func main() {
	setConfig()
	http.HandleFunc("/v1/flight/flights", fetchFlights)
	http.HandleFunc("/v1/flight/book", bookFlights)
	http.ListenAndServe("localhost:1729", nil)
}
