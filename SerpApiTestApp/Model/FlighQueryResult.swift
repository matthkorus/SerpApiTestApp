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
	let searchMetadata: SearchMetadata?
	let searchParameters: SearchParameters?
	let bestFlights, otherFlights: [Flight]?
	let priceInsights: PriceInsights?
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
	let airline: Airline?
	let airlineLogo: String?
	let travelClass: TravelClass?
	let flightNumber: String?
	let legroom: Legroom?
	let extensions: [String]?
	let overnight: Bool?
}

enum Airline: String,Codable {
	case delta
	case frontier
	case southwest
}

// MARK: - Airport
struct Airport:Codable {
	let name, id, time: String?
}

enum Legroom: String,Codable {
	case the28In
	case the31In
}

enum TravelClass: String,Codable {
	case economy
	case premiumEconomy
	case business
	case first
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
}

// MARK: - SearchMetadata
struct SearchMetadata:Codable {
	let id, status: String?
	let jsonEndpoint: String?
	let createdAt, processedAt: String?
	let googleFlightsURL: String?
	let rawHTMLFile: String?
	let prettifyHTMLFile: String?
	let totalTimeTaken: Double?
}

// MARK: - SearchParameters
struct SearchParameters:Codable {
	let engine, hl, gl, departureID: String?
	let arrivalID, outboundDate, returnDate: String?
	let travelClass, adults: Int?
	let currency: String?
}
