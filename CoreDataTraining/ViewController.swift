//
//  ViewController.swift
//  CoreDataTraining
//
//  Created by Źmicier Fiedčanka on 8.01.21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationItem.title = "Companies"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAddCompany))
        
        setupNavigationStyle()
    }
    
    
    func setupNavigationStyle() {
        navigationController?.navigationBar.isTranslucent = false
        //let lightRed = UIColor(red: 247/255, green: 66/255, blue: 82/255, alpha: 1)
        //navigationController?.navigationBar.tintColor = lightRed
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
    }
    
    @objc func handleAddCompany() {
        print("adding")
    }
}

