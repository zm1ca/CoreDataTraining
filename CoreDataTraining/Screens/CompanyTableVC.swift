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
        navigationItem.leftBarButtonItem  = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleReset))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAddCompany))
        
        fetchCompanies()
    }
    
    
    @objc private func handleReset() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Company.fetchRequest())
        do {
            try context.execute(batchDeleteRequest)
            
            var indexPathsToRemove = [IndexPath]()
            for (index, _) in companies.enumerated() {
                indexPathsToRemove.append(IndexPath(row: index, section: 0))
            }
            companies.removeAll()
            tableView.deleteRows(at: indexPathsToRemove, with: .left)
 
        } catch let deleteError {
            print("Failed to delete objects from Core Data: \(deleteError)")
        }
    }
    
    
    @objc private func handleAddCompany() {
        let createCompanyController = CreateCompanyVC()
        createCompanyController.delegate = self
        
        let navController = LightContentNavigationController(rootViewController: createCompanyController)
        
        present(navController, animated: true)
    }
    
    
    private func fetchCompanies() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        
        do {
            let companies = try context.fetch(fetchRequest)
            self.companies = companies
            tableView.reloadData()
            
        } catch let error {
            print("Failed to fetch companies:", error)
        }
    }
    
    
    //MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)

        cell.backgroundColor = .CDTTealColor
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        let company = companies[indexPath.row]
        if let name = company.name, let founded = company.founded {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            
            let dateString = "\(name) - Founded: \(formatter.string(from: founded))"
            cell.textLabel?.text = dateString
            
        } else {
            cell.textLabel?.text = company.name
        }
        
        if let imageData = company.imageData {
            cell.imageView?.image = UIImage(data: imageData)
        } else {
            cell.imageView?.image = #imageLiteral(resourceName: "select_photo_empty")
        }
        
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
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "No companies available..."
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return companies.isEmpty ? 100 : 0
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
        deleteAction.backgroundColor = .CDTLightRed
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, _) in
            let editCompanyController = CreateCompanyVC()
            editCompanyController.delegate = self
            editCompanyController.company = self.companies[indexPath.row]
            let navController = LightContentNavigationController(rootViewController: editCompanyController)
            self.present(navController, animated: true, completion: nil)
        }
        editAction.backgroundColor = .CDTDarkBlue

        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
}


extension CompanyTableVC: CreateCompanyVCDelegate {
    func addCompany(company: Company) {
        companies.append(company)
        let newIndexPath = IndexPath(row: companies.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    func editCompany(company: Company) {
        let row = companies.firstIndex(of: company)
        let editingIndexPath = IndexPath(row: row!, section: 0)
        tableView.reloadRows(at: [editingIndexPath], with: .middle)
    }
}
