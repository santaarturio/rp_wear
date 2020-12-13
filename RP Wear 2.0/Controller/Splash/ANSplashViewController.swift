//
//  ANSplashViewController.swift
//  RP Wear 2.0
//
//  Created by Macbook Pro  on 01.12.2020.
//

import UIKit

final class ANSplashViewController: UIViewController {
    
    private let animationDuration = 3.0

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var logoBackImageView: UIImageView!
    @IBOutlet weak var logoCharsImageView: UIImageView!
    @IBOutlet weak var logoBrushImageView: UIImageView!
    @IBOutlet weak var logoPaletteImageView: UIImageView!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: animationDuration / 2) { [self] in
            logoBackImageView.transform = .init(scaleX: 4.0, y: 4.0)
            logoCharsImageView.transform = .init(scaleX: 5.0, y: 5.0)
            logoBrushImageView.transform = .init(scaleX: 6.0, y: 6.0)
            logoPaletteImageView.transform = .init(scaleX: 7.0, y: 7.0)
        }
        UIView.animate(withDuration: animationDuration / 2) { [self] in
            logoBackImageView.transform = .identity
            logoCharsImageView.transform = .identity
            logoBrushImageView.transform = .identity
            logoPaletteImageView.transform = .identity
            backgroundImage.alpha = 0.0
        } completion: { [self] (_) in
            view.removeFromSuperview()
        }
    }
}
