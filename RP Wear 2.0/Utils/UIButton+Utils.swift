//
//  UIButton+Utils.swift
//  RP Wear 2.0
//
//  Created by Macbook Pro  on 10.11.2020.
//

import Foundation
import UIKit

extension UIButton {
    
    public func activateButton() {
        
        self.isUserInteractionEnabled = true
        self.isEnabled = true
        self.alpha = 1.0
    }
    
    public func deActivateButton(completely: Bool) {
        
        if completely {
            self.isUserInteractionEnabled = false
            self.isEnabled = false
            self.alpha = 0.0
        } else {
            self.isUserInteractionEnabled = false
            self.isEnabled = false
            self.alpha = 0.5
        }
    }
    
    public func setNiceCorner(radius: CGFloat?) {
        
        if let radius = radius {
            self.layer.cornerRadius = radius
        } else {
            self.layer.cornerRadius = 7.5
        }
    }
}
