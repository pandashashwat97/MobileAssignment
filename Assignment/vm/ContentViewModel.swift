//
//  ContentViewModel.swift
//  Assignment
//
//  Created by Kunal on 10/01/25.
//

import Foundation
import SwiftData
import SwiftUI

class ContentViewModel : ObservableObject {
    
    private let apiService = ApiService()
    @Published var navigateDetail: DeviceData? = nil
    @Published var data: [DeviceData]? = []
    var modelContext: ModelContext
    @Query var listData: [DeviceSwiftData]
    
    func fetchAPI() {
        apiService.fetchDeviceDetails(modelContext: modelContext, completion: { item in
            self.data = item
        })
        
    }
    
    func navigateToDetail(navigateDetail: DeviceSwiftData) {
        DispatchQueue.main.async{
            self.navigateDetail = navigateDetail
        }
    }
}
