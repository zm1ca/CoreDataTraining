//
//  EmployeeType.swift
//  CoreDataTraining
//
//  Created by Źmicier Fiedčanka on 12.01.21.
//

import Foundation

enum EmployeeType: String, CaseIterable {
    case Executive
    case SeniorManagement = "Senior Management"
    case Staff
    
    static var allRaws: [String] {
        return allCases.map {$0.rawValue}
    }
}
