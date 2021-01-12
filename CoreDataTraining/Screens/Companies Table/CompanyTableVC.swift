//
//  ViewController.swift
//  CoreDataTraining
//
//  Created by Źmicier Fiedčanka on 8.01.21.
//

import UIKit
import CoreData

class CompanyTableVC: UITableViewController {
    
    var companies = [Company]()


    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(CompanyCell.self, forCellReuseIdentifier: "cellid")
        tableView.delegate = self
        tableView.dataSource = self

        tableView.backgroundColor = .CDTDarkBlue
        tableView.separatorColor  = .white
        tableView.tableFooterView = UIView()
        
        navigationItem.title = "Companies"

        navigationItem.leftBarButtonItem  = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleReset))
        setupPlusButtonInNavBar(selector: #selector(handleAddCompany))
        
        if let fetchedCompanies = CoreDataManager.shared.fetchCompanies() {
            self.companies = fetchedCompanies
        }
    }
    
    
    @objc private func handleReset() {
        CoreDataManager.shared.reset()
        
        var indexPathsToRemove = [IndexPath]()
        for (index, _) in companies.enumerated() {
            indexPathsToRemove.append(IndexPath(row: index, section: 0))
        }
        companies.removeAll()
        tableView.deleteRows(at: indexPathsToRemove, with: .left)
    }
    
    
    @objc private func handleAddCompany() {
        let createCompanyController = CreateCompanyVC()
        createCompanyController.delegate = self
        
        let navController = LightContentNavigationController(rootViewController: createCompanyController)
        
        present(navController, animated: true)
    }
}
