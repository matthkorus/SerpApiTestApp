//
//  FlightStore.swift
//  SerpApiTestApp
//
//  Created by Matt Korus on 1/13/24.
//

import Foundation
import FirebaseFirestore

class FlightStore: ObservableObject {
	@Published var queryResults = [FlightQueryResult]()
	private let ref = db.collection("queries")
	
	init() {
		Task {
			await getFlightQueryResultsFromFirestore()
		}
	}
	
	func refresh() async {
		await getFlightQueryResultsFromFirestore()
	}
	
	@MainActor
	private func getFlightQueryResultsFromFirestore() async {
		do {
			let snapshot = try await ref.getDocuments()
			let dataArray = snapshot.documents.compactMap{
				return try? $0.data(as: [String:String].self)["json_data"] //?.data(using:.utf8)
			}
			let test = dataArray.first!
			let testData = Data(test.utf8)
			let decoder = JSONDecoder()
			do {
				let test = try decoder.decode(FlightQueryResult.self, from: testData)
				
			} catch {
				print(error)
			}
			self.queryResults = dataArray.compactMap({
				do {
					return try JSONDecoder().decode(FlightQueryResult.self, from:Data($0.utf8))
				} catch {
					print(error)
					return nil
				}
			})
		} catch {
			print(error)
		}
	}
}

