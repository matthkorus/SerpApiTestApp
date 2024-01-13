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
			Chart {
				ForEach(flightStore.queryResults, id:\.uid) { query in
					LineMark(
						x: .value("Date", query.creationDate),
						y: .value("Price", query.cheapestPrice)
					)
					.foregroundStyle(by: .value("Path", query.cheapestFlight?.flightLabel ?? "Unkown"))
					.symbol(by: .value("Path", query.cheapestFlight?.flightLabel ?? "Unkown"))
				}
			}
			.chartXAxisLabel("Date")
			.chartYAxisLabel("Price")
			.chartLegend(position:.trailing)
		}
        .padding()
    }
}

struct ChartHeader: View {
	@EnvironmentObject var flightStore: FlightStore
	@State private var selectedQueryHTML: String?
	@State private var showSheet = false
	
	var body: some View {
		HStack {
			Text("Flight Tracking for Maddie & David's Wedding").font(.title)
			Spacer()
			Button {
				Task {
					await flightStore.refresh()
				}
			} label: {
				Image(systemName: "arrow.clockwise")
			}
		}
	}
}
