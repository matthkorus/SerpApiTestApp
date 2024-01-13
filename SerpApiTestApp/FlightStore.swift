//
//  FlightStore.swift
//  SerpApiTestApp
//
//  Created by Matt Korus on 1/13/24.
//

import Foundation
import FirebaseFirestore

class FlightStore: ObservableObject {
	private let ref = db.collection("queries")
	
	init() {
		Task {
			await getFlightQueryResultsFromFirestore()
		}
	}
	
	private func getFlightQueryResultsFromFirestore() async {
		do {
			let documents = try await ref.getDocuments()
		} catch {
			print("error grabbing documents from Firestore")
		}
	}
}
