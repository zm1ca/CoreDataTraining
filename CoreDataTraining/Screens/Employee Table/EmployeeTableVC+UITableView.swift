//
//  EmployeeTableVC+UITableView.swift
//  CoreDataTraining
//
//  Created by Źmicier Fiedčanka on 12.01.21.
//

import UIKit

extension EmployeeTableVC {

    var employeeSections: [[Employee]] {
        EmployeeType.allCases.map { employeeType in
            employees.filter { $0.type == employeeType.rawValue }
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return employeeSections.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = IndentedLabel()
        label.text              = EmployeeType.allRaws[section]
        label.textColor         = .CDTDarkBlue
        label.font              = UIFont.boldSystemFont(ofSize: 16)
        label.backgroundColor   = .CDTLightBlue
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeSections[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell", for: indexPath)
        
        
        cell.backgroundColor        = .CDTTealColor
        cell.textLabel?.textColor   = .white
        cell.textLabel?.font        = UIFont.boldSystemFont(ofSize: 16)
        
        let employee = employeeSections[indexPath.section][indexPath.row]
        if let name = employee.name, let birthday = employee.employeeInformation?.birthday {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium

            cell.textLabel?.text = "\(name) - Birthday: \(formatter.string(from: birthday))"
        }
        return cell
    }
}
