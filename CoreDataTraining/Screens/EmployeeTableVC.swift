//
//  EmployeeListVC.swift
//  CoreDataTraining
//
//  Created by Źmicier Fiedčanka on 12.01.21.
//

import UIKit

class EmployeeTableVC: UITableViewController {
    
    var company: Company?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = company?.name
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = .CDTDarkBlue
        
        setupPlusButtonInNavBar(selector: #selector(handleAdd))
    }
    
    
    @objc private func handleAdd() {
        let createEmployeeVC = CreateEmployeeVC()
        let navController = LightContentNavigationController(rootViewController: createEmployeeVC)
        present(navController, animated: true)
    }
}
