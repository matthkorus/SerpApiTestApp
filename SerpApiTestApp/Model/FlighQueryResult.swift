//
//  FlighQueryResult.swift
//  SerpApiTestApp
//
//  Created by Matt Korus on 1/13/24.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let flightQueryResult = try? JSONDecoder().decode(FlightQueryResult.self, from: jsonData)

import Foundation


// MARK: - FlightQueryResult
struct FlightQueryResult: Codable {
	let searchMetadata: SearchMetadata
	let searchParameters: SearchParameters?
	let bestFlights, otherFlights: [Flight]
	let priceInsights: PriceInsights?
	
	private enum CodingKeys: String,CodingKey {
		case searchMetadata = "search_metadata"
		case searchParameters = "search_perameters"
		case bestFlights = "best_flights"
		case otherFlights = "other_flights"
		case priceInsights = "price_insights"
	}
	
	var uid: String {
		return self.searchMetadata.id
	}
	
	var allFlights: [Flight] {
		bestFlights + otherFlights
	}
	
	var cheapestFlight: Flight? {
		allFlights.min(by: { flight1,flight2 in
			guard let price1 = flight1.price,let price2 = flight2.price else { return false }
			return price1 < price2
		})
	}
	
	var cheapestPrice: Int {
		self.cheapestFlight?.price ?? 0
	}
	
	var creationDate: Date {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd HH:mm:ss 'UTC'"
		formatter.timeZone = TimeZone(abbreviation: "UTC")
		return formatter.date(from:self.searchMetadata.createdAt) ?? Date()
	}
}

extension Array where Element == FlightQueryResult {
	var cheapestFlights:[Flight] {
		return self.compactMap{$0.cheapestFlight}
	}
	var mostRecent:[FlightQueryResult] {
		let sorted = self.sorted(by: {$0.creationDate>$1.creationDate})
		guard let newestDate = sorted.first?.creationDate else { return [] }
		return sorted.filter{$0.creationDate == newestDate}
	}
}

// MARK: - Flight
struct Flight:Codable {
	let flights: [FlightElement]?
	let layovers: [Layover]?
	let totalDuration: Int?
	let carbonEmissions: CarbonEmissions?
	let price: Int?
	let type: String?
	let airlineLogo: String?
	let departureToken: String?
	
	private enum CodingKeys: String, CodingKey {
		case flights
		case layovers
		case totalDuration = "total_duration"
		case carbonEmissions = "carbon_emissions"
		case price
		case type
		case airlineLogo = "airline_logo"
		case departureToken = "departure_token"
	}
	
	var flightLabel: String {
		return "\(self.flights?.first?.departureAirport?.id ?? "Unk") - \(self.flights?.last?.arrivalAirport?.id ?? "Unk")"
	}
}

// MARK: - CarbonEmissions
struct CarbonEmissions:Codable {
	let thisFlight, typicalForThisRoute, differencePercent: Int?
}

// MARK: - FlightElement
struct FlightElement:Codable {
	let departureAirport, arrivalAirport: Airport?
	let duration: Int?
	let airplane: String?
	let airline: String?
	let airlineLogo: String?
	let travelClass: String?
	let flightNumber: String?
	let legroom: String?
	let extensions: [String]?
	let overnight: Bool?
	
	private enum CodingKeys: String,CodingKey {
		case departureAirport = "departure_airport"
		case arrivalAirport = "arrival_airport"
		case duration
		case airplane
		case airline
		case airlineLogo = "airline_logo"
		case travelClass = "travel_class"
		case flightNumber = "flight_number"
		case legroom
		case extensions
		case overnight
	}
}

// MARK: - Airport
struct Airport:Codable {
	let name, id, time: String?
}

// MARK: - Layover
struct Layover:Codable {
	let duration: Int?
	let name, id: String?
	let overnight: Bool?
}

// MARK: - PriceInsights
struct PriceInsights:Codable {
	let lowestPrice: Int?
	let priceLevel: String?
	let typicalPriceRange: [Int]?
	
	private enum CodingKeys:String,CodingKey {
		case lowestPrice = "lowest_price"
		case priceLevel = "price_level"
		case typicalPriceRange = "typical_price_range"
	}
}

// MARK: - SearchMetadata
struct SearchMetadata:Codable {
	let id, status: String
	let jsonEndpoint: String?
	let createdAt, processedAt: String
	let googleFlightsURL: String?
	let rawHTMLFile: String?
	let prettifyHTMLFile: String
	let totalTimeTaken: Double?
	
	private enum CodingKeys: String,CodingKey {
		case id
		case status
		case jsonEndpoint = "json_endpoint"
		case createdAt = "created_at"
		case processedAt = "processed_at"
		case googleFlightsURL = "google_flights_url"
		case rawHTMLFile = "raw_html_file"
		case prettifyHTMLFile = "prettify_html_file"
		case totalTimeTaken = "total_time_taken"
	}
}

// MARK: - SearchParameters
struct SearchParameters:Codable {
	let engine, hl, gl, departureID: String?
	let arrivalID, outboundDate, returnDate: String?
	let travelClass, adults: Int?
	let currency: String?
	
	private enum CodingKeys: String,CodingKey {
		case engine
		case hl
		case gl
		case departureID = "departure_id"
		case arrivalID = "arrival_id"
		case outboundDate = "outbound_date"
		case returnDate = "return_date"
		case travelClass = "travel_class"
		case adults
		case currency
	}
}
