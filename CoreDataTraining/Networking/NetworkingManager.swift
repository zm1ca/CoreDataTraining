//
//  NetworkingManager.swift
//  CoreDataTraining
//
//  Created by Źmicier Fiedčanka on 14.01.21.
//

import Foundation

struct NetworkingManager {
    
    static let shared = NetworkingManager()
    
    let sampleCompaniesURLString = "https://api.letsbuildthatapp.com/intermediate_training/companies"
    
    func downloadCompaniesFromServer() {
        guard let sampleCompaniesURL = URL(string: sampleCompaniesURLString) else { return }
        let request = URLRequest(url: sampleCompaniesURL)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            
            if let err = error {
                print("Failed to download companies: \(err)")
                return
            }

            
            let decoder = JSONDecoder()
            do {
                let jsonCompanies = try decoder.decode([JSONCompany].self, from: data)
                jsonCompanies.forEach { (company) in
                    print(company.name)
                    company.employees?.forEach { employee in
                        print("  \(employee.name)")
                    }
                }
            } catch let jsonDecodeError {
                print("JSON Decoding failed: \(jsonDecodeError)")
            }

        }.resume()
    }
    
}
