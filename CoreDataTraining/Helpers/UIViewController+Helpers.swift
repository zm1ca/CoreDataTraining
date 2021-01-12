//
//  UIViewController+Helpers.swift
//  CoreDataTraining
//
//  Created by Źmicier Fiedčanka on 12.01.21.
//

import UIKit

extension UIViewController {
    
    func setupRightBarButtonItemAsPlus(selector: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: #imageLiteral(resourceName: "plus"),
            style: .plain,
            target: self,
            action: selector
        )
    }
    
    
    func setupRightBarButtonItemAsSave(selector: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Save",
            style: .plain,
            target: self,
            action: selector
        )
    }
    
    
    func setupLeftBarButtonItemAsCancel() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(handleCancel)
            )
    }
    
    @objc private func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    
    func setupLightBlueBackgroundView(height: CGFloat) {
        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = .CDTLightBlue
        
        view.addSubview(backgroundView)
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            backgroundView.heightAnchor.constraint(equalToConstant: height)
        ])
    }
}
