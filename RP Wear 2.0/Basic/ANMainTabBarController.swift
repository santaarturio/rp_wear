//
//  ANMainTabBarController.swift
//  RP Wear 2.0
//
//  Created by Macbook Pro  on 30.11.2020.
//

import UIKit

class ANMainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(cartOrdersArrayChanged(sender:)),
                                               name: .CartOrdersArrayChanged, object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cartOrdersArrayChanged(sender: Notification(name: .CartOrdersArrayChanged))
    }
    //MARK: - Action
    @objc private func cartOrdersArrayChanged(sender: Notification) {
        let value = CartManager.shared.getOrdersArrayCount() != 0 ?
            CartManager.shared.getOrdersArrayCount().description : nil
        tabBar.items?.last?.badgeValue = value
    }
}
