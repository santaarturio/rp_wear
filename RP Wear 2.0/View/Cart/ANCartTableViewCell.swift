//
//  ANCartTableViewCell.swift
//  RP Wear 2.0
//
//  Created by Macbook Pro  on 22.11.2020.
//

import UIKit

class ANCartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    public func refresh(product: Product) {
        productImageView.image = UIImage(named: product.productImageName)
        productNameLabel.text = product.name
        descriptionLabel.text = product.description
        priceLabel.text = "Цена: \(product.price)"
    }
}
