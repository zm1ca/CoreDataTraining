//
//  CreateEmployeeVC.swift
//  CoreDataTraining
//
//  Created by Źmicier Fiedčanka on 12.01.21.
//

import UIKit

protocol CreateEmployeeVCDelegate {
    func addEmployee(employee: Employee)
}


class CreateEmployeeVC: UIViewController {
    
    var delegate: CreateEmployeeVCDelegate?
    
    var company: Company?
    
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
        
        navigationItem.title = "Create Employee"
        setupLeftBarButtonItemAsCancel()
        setupRightBarButtonItemAsSave(selector: #selector(handleSave))
        
        setupUI()
    }
    
    
    @objc private func handleSave() {
        guard let employeeName = nameTextField.text, let company = company else { return }
        
        let (employee, error) = CoreDataManager.shared.createEmployee(name: employeeName, company: company)
        if let error = error {
            print("Error while saving: \(error)")
        } else {
            dismiss(animated: true) {
                guard let employee = employee else { return }
                self.delegate?.addEmployee(employee: employee)
            }
        }
    }
    
    
    private func setupUI() {
        setupLightBlueBackgroundView(height: 50)
        
        let padding: CGFloat = 16
        
        view.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            nameLabel.widthAnchor.constraint(equalToConstant: 100),
            nameLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
        view.addSubview(nameTextField)
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor)
        ])
    }
}
