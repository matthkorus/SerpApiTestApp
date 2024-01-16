//
//  ChartHeader.swift
//  SerpApiTestApp
//
//  Created by Matt Korus on 1/14/24.
//

import SwiftUI

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
