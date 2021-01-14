//
//  CompaniesAutoUpdateVC.swift
//  CoreDataTraining
//
//  Created by Źmicier Fiedčanka on 14.01.21.
//

import UIKit
import CoreData

class CompaniesAutoUpdateVC: UITableViewController {
    
    lazy var fetchedResultsController: NSFetchedResultsController<Company> = {
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let request: NSFetchRequest<Company> = Company.fetchRequest()
        
        request.sortDescriptors = [
            NSSortDescriptor(key: "name", ascending: true)
        ]
        
        let frc = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: context,
            sectionNameKeyPath: "name",
            cacheName: nil)
        
        frc.delegate = self
        
        do {
            try frc.performFetch()
        } catch let err {
            print(err)
        }
        
        return frc
        
    }()
        

    let cellId = "cellId"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .CDTDarkBlue
        
        navigationItem.title = "Companies Auto"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(handleDelete))
        setupRightBarButtonItemAsPlus(selector: #selector(handleAdd))
        
        tableView.register(CompanyCell.self, forCellReuseIdentifier: cellId)

        
        NetworkingManager.shared.downloadCompaniesFromServer()
    }
    
    
    @objc private func handleAdd() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let company = Company(context: context)
        company.name = "Zool"
        
        try? context.save()
    }
    
    @objc private func handleDelete() {
        let request: NSFetchRequest<Company> = Company.fetchRequest()
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let companiesWithO = try? context.fetch(request)
        
        companiesWithO?.forEach { (company) in
            context.delete(company)
        }
        
        try? context.save()
    }
}
