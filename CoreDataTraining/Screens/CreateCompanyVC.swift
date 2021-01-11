//
//  CreateCompanyController.swift
//  CoreDataTraining
//
//  Created by Źmicier Fiedčanka on 10.01.21.
//

import UIKit
import CoreData

protocol CreateCompanyVCDelegate {
    func addCompany(company: Company)
    func editCompany(company: Company)
}

class CreateCompanyVC: UIViewController {
    
    var company: Company? {
        didSet {
            nameTextField.text = company?.name
            
            guard let founded = company?.founded else { return }
            datePicker.date = founded
        }
    }
    
    var delegate: CreateCompanyVCDelegate?
    
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
    
    let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        dp.translatesAutoresizingMaskIntoConstraints = false
        return dp
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = company == nil ? "Create Company" : "Edit Company"
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .CDTDarkBlue
        
        setupUI()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    }
    
    
    @objc private func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    
    @objc private func handleSave() {
        if company == nil {
            createCompany()
        } else {
            editCompany()
        }
    }
    
    
    private func createCompany() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
        company.setValue(nameTextField.text, forKey: "name")
        company.setValue(datePicker.date, forKey: "founded")
        
        do {
            try context.save()
            
            dismiss(animated: true) {
                self.delegate?.addCompany(company: company as! Company)
            }
            
        } catch let saveError {
            print("Failed to save company:", saveError)
        }
    }
    
    
    private func editCompany() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        company?.name    = nameTextField.text
        company?.founded = datePicker.date
        
        do {
            try context.save()
            
            dismiss(animated: true) {
                self.delegate?.editCompany(company: self.company!)
            }
            
        } catch let savingError {
            print("Saving error: \(savingError)")
        }
    }
    
    private func setupUI() {
        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = .CDTLightBlue
        
        let padding: CGFloat = 16
        
        view.addSubview(backgroundView)
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.heightAnchor.constraint(equalToConstant: 100)
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
        
        
        backgroundView.addSubview(datePicker)
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            datePicker.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: padding),
            datePicker.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -padding),
            datePicker.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -padding)
        ])
    }
}
