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
        let properSection = EmployeeType.allRaws.firstIndex(of: employee.type!)!
        let newIndexPath = IndexPath(row: employeeSections[properSection].count - 1, section: properSection)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
}
