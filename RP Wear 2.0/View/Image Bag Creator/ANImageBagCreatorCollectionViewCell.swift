//
//  ANImageBagCreatorCollectionViewCell.swift
//  RP Wear 2.0
//
//  Created by Macbook Pro  on 17.11.2020.
//

import UIKit

class ANImageBagCreatorCollectionViewCell: UICollectionViewCell {
    
    override var isHighlighted: Bool {
        didSet { UIView.animate(withDuration: 0.3) {
            self.transform = self.isHighlighted ? CGAffineTransform(scaleX: 0.85, y: 0.85) : .identity
        }
        }
    }
    
    @IBOutlet weak var myImageView: UIImageView!
    
    public func configureWith(imageName: String) {
        myImageView.image = UIImage(named: imageName)
        layer.cornerRadius = 7.5
    }
}
