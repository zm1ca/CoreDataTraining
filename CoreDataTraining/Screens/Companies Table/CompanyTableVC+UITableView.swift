//
//  CompaniesTableVC+UITableView.swift
//  CoreDataTraining
//
//  Created by Źmicier Fiedčanka on 12.01.21.
//

import UIKit

extension CompanyTableVC {
    
    //MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath) as! CompanyCell
        cell.company = companies[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    //MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let company = self.companies[indexPath.row]
        let employeeTableController = EmployeeTableVC()
        employeeTableController.company = company
        navigationController?.pushViewController(employeeTableController, animated: true)
    }
    
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
        
        //MARK: Delete Swipe Action Handler
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {  (_, _, _) in
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
        
        //MARK: Edit Swipe Action Handler
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
