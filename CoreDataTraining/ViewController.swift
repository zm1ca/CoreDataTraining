//
//  ViewController.swift
//  CoreDataTraining
//
//  Created by Źmicier Fiedčanka on 8.01.21.
//

import UIKit

class ViewController: UITableViewController {

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
        
        setupNavigationStyle()
    }
    
    
    func setupNavigationStyle() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationBar.prefersLargeTitles = true
        navigationBar.standardAppearance = navBarAppearance()
        navigationBar.scrollEdgeAppearance = navBarAppearance()
    }
    
    
    func navBarAppearance() -> UINavigationBarAppearance {
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = .CDTLightRed
        
        return navBarAppearance
    }
    
    @objc func handleAddCompany() {
        print("adding")
    }
    
    
    //MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        cell.backgroundColor = .CDTTealColor
        cell.textLabel?.text = "THE COMPANY NAME"
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
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
