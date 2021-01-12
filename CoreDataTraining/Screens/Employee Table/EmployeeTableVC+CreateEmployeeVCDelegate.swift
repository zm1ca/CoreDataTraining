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
        tableView.reloadData()
    }
}
