//
//  JSONCompany.swift
//  CoreDataTraining
//
//  Created by Źmicier Fiedčanka on 14.01.21.
//

import Foundation

struct JSONCompany: Codable {
    
    let name: String
    let founded: String
    var employees: [JSONEmployee]?
}


struct JSONEmployee: Codable {
    
    let name: String
    let type: String
    let birthday: String
}
