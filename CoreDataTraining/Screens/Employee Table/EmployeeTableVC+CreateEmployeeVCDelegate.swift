//
//  EmployeeTableVC+CreateEmployeeVCDelegate.swift
//  CoreDataTraining
//
//  Created by Źmicier Fiedčanka on 12.01.21.
//

import Foundation

extension EmployeeTableVC: CreateEmployeeVCDelegate {
    
    func addEmployee(employee: Employee) {
        employees.append(employee)
        let newIndexPath = IndexPath(row: employees.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
}
