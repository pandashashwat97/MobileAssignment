//
//  ApiService.swift
//  Assignment
//
//  Created by Kunal on 10/01/25.
//

import Foundation
import SwiftUI
import SwiftData

class ApiService : NSObject {
    private let baseUrl = ""
    
    private let sourcesURL = URL(string: "https://api.restful-api.dev/objects")!
    
    func fetchDeviceDetails(modelContext:ModelContext, completion : @escaping ([DeviceSwiftData]) -> ()){
        URLSession.shared.dataTask(with: sourcesURL) { (data, urlResponse, error) in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                completion([]) // Return an empty array on network failure
                return
            }
            
            if let data = data {
                let jsonDecoder = JSONDecoder()
                let empData = try! jsonDecoder.decode([DeviceData].self, from: data)
                if (empData.isEmpty) {
                    completion([])
                }
                empData.forEach { item in
                    let object = DeviceSwiftData(deviceName: item.name, capacity: item.data?.capacity ?? "")
                    modelContext.insert(object)
                }
            }
        }.resume()
    }
}
