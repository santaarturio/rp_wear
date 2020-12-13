//
//  SplashManager.swift
//  RP Wear 2.0
//
//  Created by Macbook Pro  on 08.12.2020.
//

import Foundation
import TinyConstraints
import UIKit

class SplashManager {
    static let shared = SplashManager()
    private init() {}
    
    public func setupSplashFrom(_ parentVC: UIViewController) {
        let identifier = String(describing: ANSplashViewController.self)
        let storyboard = UIStoryboard(name: identifier, bundle: nil)
        guard let splashVC = storyboard.instantiateViewController(identifier: identifier) as? ANSplashViewController else { return }
        
        parentVC.view.addSubview(splashVC.view)
        splashVC.view.edgesToSuperview()
    }
}
