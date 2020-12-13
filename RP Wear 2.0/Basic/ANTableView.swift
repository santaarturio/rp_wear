//
//  ANTableView.swift
//  RP Wear 2.0
//
//  Created by Macbook Pro  on 27.11.2020.
//

import UIKit

class ANTableView: UITableView {
    public var index = 0
    public func setup(with index: Int) {
        self.index = index
        layer.cornerRadius = 7.5
        clipsToBounds = true
    }
}
