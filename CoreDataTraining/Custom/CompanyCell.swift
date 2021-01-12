//
//  CompanyCell.swift
//  CoreDataTraining
//
//  Created by Źmicier Fiedčanka on 12.01.21.
//

import UIKit

class CompanyCell: UITableViewCell {
    
    var company: Company? {
        didSet {
            guard let company = company else { return }
            
            nameFoundedDateLabel.textColor = .white
            nameFoundedDateLabel.font = UIFont.boldSystemFont(ofSize: 16)
            
            if let name = company.name, let founded = company.founded {
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                let dateString = "\(name) - Founded: \(formatter.string(from: founded))"
                nameFoundedDateLabel.text = dateString
            } else {
                nameFoundedDateLabel.text = company.name
            }
            
            if let imageData = company.imageData {
                companyImageView.image = UIImage(data: imageData)
            } else {
                companyImageView.image = #imageLiteral(resourceName: "select_photo_empty")
            }
        }
    }
    
    let companyImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "select_photo_empty"))
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.CDTDarkBlue.cgColor
        imageView.layer.borderWidth = 1
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameFoundedDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .CDTTealColor
        
        let padding: CGFloat = 16
        
        addSubview(companyImageView)
        NSLayoutConstraint.activate([
            companyImageView.heightAnchor.constraint(equalToConstant: 50),
            companyImageView.widthAnchor.constraint(equalToConstant: 50),
            companyImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            companyImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        addSubview(nameFoundedDateLabel)
        NSLayoutConstraint.activate([
            nameFoundedDateLabel.topAnchor.constraint(equalTo: topAnchor),
            nameFoundedDateLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            nameFoundedDateLabel.leadingAnchor.constraint(equalTo: companyImageView.trailingAnchor, constant: padding),
            nameFoundedDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: padding)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
