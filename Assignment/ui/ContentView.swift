//
//  ContentView.swift
//  Assignment
//
//  Created by Kunal on 03/01/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @ObservedObject var viewModel = ContentViewModel()
    @State private var path: [DeviceSwiftData] = [] // Navigation path\
    @Environment(\.modelContext) var modelContext
    @Query var listData: [DeviceSwiftData]
    
    var body: some View {
        NavigationStack(path: $path) {
            Group {
                if let computers = viewModel.data, !computers.isEmpty {
                    DevicesList(devices: computers) { selectedComputer in
                        viewModel.navigateToDetail(navigateDetail: selectedComputer)
                    }
                } else {
                    ProgressView("Loading...")
                }
            }
            .onChange(of: viewModel.navigateDetail, {
                let navigate = viewModel.navigateDetail
                path.append(navigate!)
            })
            .navigationTitle("Devices")
            .navigationDestination(for: DeviceData.self) { computer in
                DetailView(device: computer)
            }
            .onAppear {
                let navigate = viewModel.navigateDetail
                if (navigate != nil) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        path.append(navigate!)
                    }
                }
            }
            .task {
                viewModel.fetchAPI()
            }
        }
    }
}
