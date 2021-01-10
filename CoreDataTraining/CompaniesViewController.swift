//
//  ViewController.swift
//  CoreDataTraining
//
//  Created by Źmicier Fiedčanka on 8.01.21.
//

import UIKit

class CompaniesViewController: UITableViewController {
    
    let companies = [
        Company(name: "Google", founded: Date()),
        Company(name: "Facebook", founded: Date()),
        Company(name: "Apple", founded: Date())
    ]
    

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
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAddCompany))
    }
    
    
    @objc func handleAddCompany() {
        let createCompanyController = CreateCompanyController()
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
}
