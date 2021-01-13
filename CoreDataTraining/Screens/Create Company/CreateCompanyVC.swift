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
            
            if let imageData = company?.imageData {
                companyImageView.image = UIImage(data: imageData)
            }
            
            guard let founded = company?.founded else { return }
            datePicker.date = founded
        }
    }
    
    var delegate: CreateCompanyVCDelegate?
    
    
    //MARK: - UI Elements
    lazy var companyImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "select_photo_empty"))
        
        imageView.contentMode = .scaleAspectFill
        
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.clipsToBounds      = true
        imageView.layer.borderColor  = UIColor.CDTDarkBlue.cgColor
        imageView.layer.borderWidth  = 2
        
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectPhoto)))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    @objc private func handleSelectPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate      = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true)
    }

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
    
    
    //MARK: - VC Lifecycle methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = company == nil ? "Create Company" : "Edit Company"
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .CDTDarkBlue
        
        setupUI()
        
        setupLeftBarButtonItemAsCancel()
        setupRightBarButtonItemAsSave(selector: #selector(handleSave))
    }
    
    
    //MARK: - Private functionality
    @objc private func handleSave() {
        if company == nil {
            createCompany()
        } else {
            editCompany()
        }
    }
    
    
    private func createCompany() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let company = Company(context: context)
        
        company.setValue(nameTextField.text, forKey: "name")
        company.setValue(datePicker.date, forKey: "founded")
        if let companyImage = companyImageView.image {
            let encodedImage = companyImage.jpegData(compressionQuality: 0.8)
            #warning("encodedImage is empty if companyImage was taken from assets")
            company.setValue(encodedImage, forKey: "imageData")
        }

        do {
            try context.save()
            
            dismiss(animated: true) {
                self.delegate?.addCompany(company: company)
            }
            
        } catch let saveError {
            print("Failed to save company:", saveError)
        }
    }
    
    
    private func editCompany() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        company?.name    = nameTextField.text
        company?.founded = datePicker.date
        
        if let companyImage = companyImageView.image {
            let encodedImage = companyImage.jpegData(compressionQuality: 0.8)
            company?.imageData = encodedImage
        }
        
        do {
            try context.save()
            
            dismiss(animated: true) {
                self.delegate?.editCompany(company: self.company!)
            }
            
        } catch let savingError {
            print("Saving error: \(savingError)")
        }
    }
    
    
    //MARK: - Laying out UI
    private func setupUI() {

        setupLightBlueBackgroundView(height: 216)
        
        let padding: CGFloat = 16

        
        view.addSubview(companyImageView)
        NSLayoutConstraint.activate([
            companyImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            companyImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            companyImageView.heightAnchor.constraint(equalToConstant: 100),
            companyImageView.widthAnchor.constraint(equalToConstant: 100),
        ])
        
        
        view.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: companyImageView.bottomAnchor),
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
        
        
        view.addSubview(datePicker)
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            datePicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            datePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            datePicker.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}



