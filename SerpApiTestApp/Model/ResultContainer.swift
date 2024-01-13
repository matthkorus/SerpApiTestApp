//
//  ResultContainer.swift
//  SerpApiTestApp
//
//  Created by Matt Korus on 1/13/24.
//

import Foundation

struct ResultContainer: Codable {
	let jsonData: String // kind of a bad name - since this is afterall, a string
	var json: Data? {
		jsonData.data(using: .utf8)
	}
	
	private enum CodingKeys: String,CodingKey {
		case jsonData = "json_data"
	}
	
	func flightResults() -> FlightQueryResult? {
		guard let json = self.json else { return nil }
		var results: FlightQueryResult?
		do {
			results = try JSONDecoder().decode(FlightQueryResult.self, from: json)
		} catch {
			print("Failed to decode json: \(json)")
		}
		return results
	}
}
