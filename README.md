# flight-booking-service
A small demo project on booking flights.

Following REST API endpoints are supported, will keep adding more.
1. /flight/flights: Send origin, destination, stops, class and date for flight as query parameters in GET request.
   Ex:
   1. Request
      flight/flights?origin=BLR&destination=CCU&stops=0&class=Economy&date=2024-08-19
   2. Response
      {
          "flightsList": [
              {
                  "flightId": "6E803",
                  "departure": "12:00:00",
                  "arrival": "14:15:00"
              }
          ]
      }
   
3. /flight/book: Send a POST request with flightId(from above request), passengers list, date and class.
   Ex:
   1. Request json
      {
         "flightId": "6E803",
         "passengers": [
            {
               "age": 24,
               "firstname": "jon",
               "lastname": "doe",
               "email": "jondoe@example.com",
               "gender": "male"
            },
            {
               "age": 27,
               "firstname": "alice",
               "lastname": "doe",
               "email": "alicedoe@example.com",
               "gender": "female"
            }
         ],
         "date": "2024-08-19",
         "class": "economy"
      }
   2. Response json:
      {
          "pnr": "TXQ173",
          "passengers": [
              {
                  "age": 24,
                  "firstname": "jon",
                  "lastname": "doe",
                  "email": "jondoe@example.com",
                  "gender": "male"
              },
              {
                  "age": 27,
                  "firstname": "alice",
                  "lastname": "doe",
                  "email": "alicedoe@example.com",
                  "gender": "female"
              }
          ],
          "origin": "BLR",
          "destination": "CCU",
          "date": "2024-08-19",
          "class": "economy",
          "departure": "12:00",
          "arrival": "14:15",
          "departure_terminal": "T1",
          "arrival_terminal": "T3"
      }
