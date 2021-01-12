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
        
        
        cell.backgroundColor        = .CDTTealColor
        cell.textLabel?.textColor   = .white
        cell.textLabel?.font        = UIFont.boldSystemFont(ofSize: 16)
        
        let employee = employees[indexPath.row]
        if let name = employee.name, let birthday = employee.employeeInformation?.birthday {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium

            cell.textLabel?.text = "\(name) - Birthday: \(formatter.string(from: birthday))"
        }
        return cell
    }
}
