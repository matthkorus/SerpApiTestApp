//
//  FlightChart.swift
//  SerpApiTestApp
//
//  Created by Matt Korus on 1/14/24.
//

import SwiftUI
import Charts

struct FlightChart: View {
	@EnvironmentObject var flightStore: FlightStore
	@State private var hover: String?
	
	var body: some View {
		Chart {
			ForEach(flightStore.queryResults.sorted(by:{$0.creationDate < $1.creationDate}), id:\.uid) { query in
				let label = query.cheapestFlight?.flightLabel ?? "Unkown"
				LineMark(
					x: .value("Date", query.creationDate),
					y: .value("Price", query.cheapestPrice)
				)
				.foregroundStyle(by: .value("Path", label ))
				.symbol(by: .value("Path", label))
			}
		}
		.chartXAxisLabel("Date")
		.chartYAxisLabel("Price")
		.chartLegend(position:.trailing)
		.chartOverlay { (chartProxy: ChartProxy) in
			findOverlayPositionView(hover: $hover,chartProxy:chartProxy)
		}
	}
}

extension FlightChart {
	// Define a function to create a chart overlay
	func findOverlayPositionView(hover: Binding<String?>,chartProxy:ChartProxy?) -> some View {
		Color.clear
			.onContinuousHover { hoverPhase in
				switch hoverPhase {
				case .active(let hoverLocation):
					if let chartProxy = chartProxy {
						hover.wrappedValue = chartProxy.value(
							atX: hoverLocation.x, as: String.self
						)
					}
				case .ended:
					hover.wrappedValue = nil
				}
			}
	}
}
