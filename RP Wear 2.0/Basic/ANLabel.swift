//
//  ANLabel.swift
//  RP Wear 2.0
//
//  Created by Macbook Pro  on 23.11.2020.
//

import UIKit

class ANLabel: UILabel {
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0.0, left: 5.0, bottom: 0.0, right: 5.0)
        super.drawText(in: rect.inset(by: insets))
    }

    public func setup() {
        layer.cornerRadius = 15
        clipsToBounds = true
        adjustsFontSizeToFitWidth = true
    }
}
