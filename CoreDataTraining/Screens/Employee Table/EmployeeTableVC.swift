//
//  EmployeeListVC.swift
//  CoreDataTraining
//
//  Created by Źmicier Fiedčanka on 12.01.21.
//

import UIKit

class EmployeeTableVC: UITableViewController {
    
    var company: Company?
    
    var employees = [Employee]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = company?.name
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = .CDTDarkBlue
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "EmployeeCell")
        
        setupRightBarButtonItemAsPlus(selector: #selector(handleAdd))
        
        if let company = company, let fetchedEmployees = CoreDataManager.shared.fetchEmployees(of: company) {
            self.employees = fetchedEmployees
        }
    }
    
    
    @objc private func handleAdd() {
        let createEmployeeVC = CreateEmployeeVC()
        createEmployeeVC.delegate = self
        createEmployeeVC.company  = company
        let navController = LightContentNavigationController(rootViewController: createEmployeeVC)
        present(navController, animated: true)
    }
}
