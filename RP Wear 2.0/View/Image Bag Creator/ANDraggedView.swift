//
//  ANDraggedView.swift
//  RP Wear 2.0
//
//  Created by Macbook Pro  on 19.11.2020.
//

import UIKit
import SwiftyMasonry
import Masonry

class ANDraggedView: UIView {

    private var myImageView = UIImageView()
    
    public func setupWithImage(from bag: BagModel?) {
        myImageView.image = UIImage(named: bag?.bagImage ?? "logo")
        configureUI()
    }
    //MARK: - Configure
    private func configureUI() {
        myImageView.contentMode = .scaleAspectFit
        addSubview(myImageView)
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        createConstraints()
    }
    private func createConstraints() {
        myImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        myImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        myImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        myImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
