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
    
    let birthdayLabel: UILabel = {
        let label = UILabel()
        label.text = "Birthday"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let birthdayTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "MM/DD/YYYY"
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
        guard let employeeName = nameTextField.text, let company = company, let birthdayString = birthdayTextField.text else { return }
        
        if birthdayString.isEmpty {
            presentAlertOnMainThread(title: "Empty Birthday", message: "You have to enter a birthday")
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
         
        guard let birthday = dateFormatter.date(from: birthdayString) else {
            presentAlertOnMainThread(title: "Incorrect Date", message: "Birthday date entered is not valid")
            return
        }
        
        let (employee, error) = CoreDataManager.shared.createEmployee(name: employeeName, birthday: birthday, company: company)
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
        setupLightBlueBackgroundView(height: 100)
        
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
        
        
        view.addSubview(birthdayLabel)
        NSLayoutConstraint.activate([
            birthdayLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            birthdayLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            birthdayLabel.widthAnchor.constraint(equalToConstant: 100),
            birthdayLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
        view.addSubview(birthdayTextField)
        NSLayoutConstraint.activate([
            birthdayTextField.topAnchor.constraint(equalTo: birthdayLabel.topAnchor),
            birthdayTextField.leadingAnchor.constraint(equalTo: birthdayLabel.trailingAnchor),
            birthdayTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            birthdayTextField.bottomAnchor.constraint(equalTo: birthdayLabel.bottomAnchor)
        ])
    }
}
