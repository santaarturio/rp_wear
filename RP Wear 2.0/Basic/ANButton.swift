//
//  ANButton.swift
//  RP Wear 2.0
//
//  Created by Macbook Pro  on 14.11.2020.
//
import Hex
import UIKit

class ANButton: UIButton {
    private let buttonColor = UIColor(hex: "FF2C92")
    
    override var isHighlighted: Bool {
        didSet { UIView.animate(withDuration: 0.2) { [self] in
                self.transform = self.isHighlighted ? CGAffineTransform(scaleX: 0.9, y: 0.9) : .identity
            }
        }
    }
    public func setup() {
        backgroundColor = buttonColor
        layer.cornerRadius = 7.5
    }
    public func setupWithBorder() {
        backgroundColor = .clear
        layer.borderWidth = 2
        layer.borderColor = buttonColor.cgColor
        layer.cornerRadius = 7.5
    }
    
    public enum State {
        case Enabled, Disabled, Invisible
    }
    public func setActivation(onState state: State) {
        switch state {
        case .Enabled:
            isUserInteractionEnabled = true
            isEnabled = true
            alpha = 1.0
        case .Disabled:
            isUserInteractionEnabled = false
            isEnabled = false
            alpha = 0.5
        case .Invisible: 
            isUserInteractionEnabled = false
            isEnabled = false
            alpha = 0.0
        }
    }
}
