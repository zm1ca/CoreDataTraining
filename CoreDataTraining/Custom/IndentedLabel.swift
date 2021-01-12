//
//  IndentedLabel.swift
//  CoreDataTraining
//
//  Created by Źmicier Fiedčanka on 12.01.21.
//

import UIKit

class IndentedLabel: UILabel {
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        let customRect = rect.inset(by: insets)
        super.drawText(in: customRect)
    }
}
