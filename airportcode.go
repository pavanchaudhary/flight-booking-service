package main

type airportCode string

const (
	AMD airportCode = "AMD"
	HYD airportCode = "HYD"
	BLR airportCode = "BLR"
	DEL airportCode = "DEL"
	BOM airportCode = "BOM"
	CCU airportCode = "CCU"
	MAA airportCode = "MAA"
	JFK airportCode = "JFK"
	LHR airportCode = "LHR"
	DXB airportCode = "DXB"
	SIN airportCode = "SIN"
	SYD airportCode = "SYD"
)

var airportCodeMap = map[string]airportCode{
	"amd": AMD,
	"hyd": HYD,
	"blr": BLR,
	"del": DEL,
	"bom": BOM,
	"ccu": CCU,
	"maa": MAA,
	"jfk": JFK,
	"lhr": LHR,
	"dxb": DXB,
	"sin": SIN,
	"syd": SYD,
}

func GetAirportCode(ac string) airportCode {
	return airportCodeMap[ac]
}
