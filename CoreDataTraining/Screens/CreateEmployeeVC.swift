//
//  CreateEmployeeVC.swift
//  CoreDataTraining
//
//  Created by Źmicier Fiedčanka on 12.01.21.
//

import UIKit

class CreateEmployeeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Create Employee"
        setupCancelButtonInNavBar()

        view.backgroundColor = .CDTDarkBlue
    }
}
