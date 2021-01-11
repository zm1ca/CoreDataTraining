//
//  CreateCompanyController.swift
//  CoreDataTraining
//
//  Created by Źmicier Fiedčanka on 10.01.21.
//

import UIKit
import CoreData

protocol CreateCompanyControllerDelegate {
    func addCompany(company: Company)
}

class CreateCompanyController: UIViewController {
    
    var delegate: CreateCompanyControllerDelegate?
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .CDTDarkBlue
        
        setupUI()
        
        navigationItem.title = "Create Company"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    }
    
    
    @objc private func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    
    @objc private func handleSave() {
        
        //Initialization of Core Data Stack
        let persistantContainer = NSPersistentContainer(name: "CoreDataTrainingModels")
        persistantContainer.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading of store failed: \(error)")
            }
        }
        
        let context = persistantContainer.viewContext
        let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
        company.setValue(nameTextField.text, forKey: "name")
        
        //perform save
        do {
            try context.save()
        } catch let saveError {
            print("Failed to save company:", saveError)
        }
        
        
        dismiss(animated: true) {
//            guard let companyName = self.nameTextField.text else { return }
//            
//            let companyToSave = Company(name: companyName, founded: Date())
//            self.delegate?.addCompany(company: companyToSave)
        }
    }
    
    
    private func setupUI() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .CDTLightBlue
        
        let padding: CGFloat = 16
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundView)
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
        backgroundView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: padding),
            nameLabel.widthAnchor.constraint(equalToConstant: 100),
            nameLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
        backgroundView.addSubview(nameTextField)
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -padding),
            nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor)
        ])
    }
}
