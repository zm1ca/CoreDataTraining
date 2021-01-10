//
//  CreateCompanyController.swift
//  CoreDataTraining
//
//  Created by Źmicier Fiedčanka on 10.01.21.
//

import UIKit

class CreateCompanyController: UIViewController {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.backgroundColor = .red
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .CDTDarkBlue
        
        navigationItem.title = "Create Company"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
    }
    
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
}
