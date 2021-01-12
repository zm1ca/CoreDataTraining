//
//  CompanyTableVC+CreateCompanyVCDelegate.swift
//  CoreDataTraining
//
//  Created by Źmicier Fiedčanka on 12.01.21.
//

import Foundation

extension CompanyTableVC: CreateCompanyVCDelegate {
    func addCompany(company: Company) {
        companies.append(company)
        let newIndexPath = IndexPath(row: companies.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    func editCompany(company: Company) {
        let row = companies.firstIndex(of: company)
        let editingIndexPath = IndexPath(row: row!, section: 0)
        tableView.reloadRows(at: [editingIndexPath], with: .middle)
    }
}
