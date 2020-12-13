//
//  ANQuizVcTableViewHeader.swift
//  RP Wear 2.0
//
//  Created by Macbook Pro  on 27.11.2020.
//

import UIKit
import TinyConstraints
import Hex

class ANQuizVcTableViewHeader: UITableViewHeaderFooterView {
    private let label = UILabel()
    private let backgroundHexColor = "FF2F7F"

    override func draw(_ rect: CGRect) {
        label.backgroundColor = UIColor(hex: backgroundHexColor)
        label.textColor = .white
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        addSubview(label)
        label.edgesToSuperview()
    }
    public func setLabelsText(text: String) {
        label.text = text
    }
}
