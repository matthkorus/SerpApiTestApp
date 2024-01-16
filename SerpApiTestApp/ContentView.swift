//
//  ContentView.swift
//  SerpApiTestApp
//
//  Created by Matt Korus on 1/13/24.
//

import SwiftUI
import Charts

struct ContentView: View {
	@EnvironmentObject var flightStore: FlightStore
    var body: some View {
		VStack {
			ChartHeader()
			FlightChart()
		}
        .padding()
    }
}



