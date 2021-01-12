//
//  EmployeeTableVC+UITableView.swift
//  CoreDataTraining
//
//  Created by Źmicier Fiedčanka on 12.01.21.
//

import UIKit

extension EmployeeTableVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell", for: indexPath)
        let employee = employees[indexPath.row]
        
        cell.backgroundColor        = .CDTTealColor
        cell.textLabel?.textColor   = .white
        cell.textLabel?.font        = UIFont.boldSystemFont(ofSize: 16)

        cell.textLabel?.text        = "\(employee.name!) + \(employee.employeeInformation?.taxid ?? "?")"
        
        return cell
    }
}
