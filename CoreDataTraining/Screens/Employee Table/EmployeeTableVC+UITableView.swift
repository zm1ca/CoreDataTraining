//
//  EmployeeTableVC+UITableView.swift
//  CoreDataTraining
//
//  Created by Źmicier Fiedčanka on 12.01.21.
//

import UIKit

extension EmployeeTableVC {
    
    var group1: [Employee] {
        return employees.filter { $0.name!.count < 6 }
    }
    
    var group2: [Employee] {
        return employees.filter { $0.name!.count > 6 && $0.name!.count < 9 }
    }
    
    var group3: [Employee] {
        return employees.filter { $0.name!.count > 9 }
    }
    
    var allEmployees: [[Employee]] {
        return [group1, group2, group3]
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return allEmployees.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = IndentedLabel()
        var sectionTitle: String
        
        if section == 0 {
            sectionTitle = "Short"
        } else if section == 1 {
            sectionTitle = "Normal"
        } else {
            sectionTitle = "Long"
        }
        
        label.text              = sectionTitle
        label.textColor         = .CDTDarkBlue
        label.font              = UIFont.boldSystemFont(ofSize: 16)
        label.backgroundColor   = .CDTLightBlue
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allEmployees[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell", for: indexPath)
        
        
        cell.backgroundColor        = .CDTTealColor
        cell.textLabel?.textColor   = .white
        cell.textLabel?.font        = UIFont.boldSystemFont(ofSize: 16)
        
        let employee = allEmployees[indexPath.section][indexPath.row]
        if let name = employee.name, let birthday = employee.employeeInformation?.birthday {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium

            cell.textLabel?.text = "\(name) - Birthday: \(formatter.string(from: birthday))"
        }
        return cell
    }
}
