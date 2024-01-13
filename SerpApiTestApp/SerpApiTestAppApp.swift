//
//  SerpApiTestAppApp.swift
//  SerpApiTestApp
//
//  Created by Matt Korus on 1/13/24.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

let db = Firestore.firestore()

@main
struct SerpApiTestAppApp: App {
	@StateObject var flightStore = FlightStore()
	
	init() {
		FirebaseApp.configure()
	}
	
    var body: some Scene {
        WindowGroup {
            ContentView()
				.environmentObject(flightStore)
        }
    }
}
