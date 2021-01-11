//
//  ViewController.swift
//  CoreDataTraining
//
//  Created by Źmicier Fiedčanka on 8.01.21.
//

import UIKit
import CoreData

class CompaniesViewController: UITableViewController {
    
    var companies = [Company]()
    
    
    private func fetchCompanies() {
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        
        do {
            let companies = try context.fetch(fetchRequest)
            
            self.companies = companies
            self.tableView.reloadData()
            
        } catch let error {
            print("Failed to fetch companies:", error)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCompanies()
        
        //Setting up tableView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellid")
        tableView.delegate = self
        tableView.dataSource = self
        
        //Stylyzing separators
        tableView.backgroundColor = .CDTDarkBlue
        tableView.separatorColor  = .white
        tableView.tableFooterView = UIView()
        
        //Stylyzing Navigation Bar
        navigationItem.title = "Companies"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAddCompany))
    }
    
    
    @objc func handleAddCompany() {
        let createCompanyController = CreateCompanyController()
        createCompanyController.delegate = self
        
        let navController = LightContentNavigationController(rootViewController: createCompanyController)
        
        present(navController, animated: true)
    }
    
    
    //MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)

        cell.backgroundColor = .CDTTealColor
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        let company = companies[indexPath.row]
        cell.textLabel?.text = company.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    
    //MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .CDTLightBlue
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
        
            //Table View
            let company = self.companies.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)

            //Core Data
            let context = CoreDataManager.shared.persistentContainer.viewContext
            context.delete(company)
            do {
                try context.save()
            } catch let deletionError {
                print("Deletion error: \(deletionError)")
            }
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") {  (contextualAction, view, boolValue) in
            print("Attempting to edit")
        }
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction, editAction])

        return swipeActions
    }
}


extension CompaniesViewController: CreateCompanyControllerDelegate {
    func addCompany(company: Company) {
        companies.append(company)
        let newIndexPath = IndexPath(row: companies.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
}
