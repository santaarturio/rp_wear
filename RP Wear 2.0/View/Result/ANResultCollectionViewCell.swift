//
//  ANResultCollectionViewCell.swift
//  RP Wear 2.0
//
//  Created by Macbook Pro  on 20.11.2020.
//

import UIKit

class ANResultCollectionViewCell: UICollectionViewCell {
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.2) { [self] in
                self.transform = self.isHighlighted ? CGAffineTransform(scaleX: 0.9, y: 0.9) : .identity
            }
        }
    }
    
    @IBOutlet weak var myImageView: UIImageView!
    
    public func configureWith(imageName: String) {
        myImageView.image = UIImage(named: imageName)
        layer.cornerRadius = 15
    }
}
