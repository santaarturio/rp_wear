//
//  ANCartViewController.swift
//  RP Wear 2.0
//
//  Created by Macbook Pro  on 22.11.2020.
//

import UIKit

class ANCartViewController: DefaultViewController {
    private let dataSource = ANCartVcDataSource()
    private let cellIdentifier = String(describing: ANCartTableViewCell.self)
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var checkoutButton: ANButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkoutButton.setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cartTableView.reloadData()
        checkoutButton.setActivation(onState:  dataSource.getOrdersArrayCount() == 0 ? .Disabled : .Enabled)
    }
    //MARK: - IBAction
    @IBAction func checkoutButtonTapped(sender: ANButton) {
        let identifier = String(describing: ANCheckoutTableViewController.self)
        let storyboard = UIStoryboard(name: identifier, bundle: nil)
        guard let nextVC = storyboard.instantiateViewController(identifier: identifier) as? ANCheckoutTableViewController else { return }
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

//MARK: - Delegate, DataSource
extension ANCartViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        dataSource.getOrdersArrayCount()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = cartTableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ANCartTableViewCell else { return UITableViewCell() }
        cell.refresh(product: dataSource.getOrder(at: indexPath.section))
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        cartTableView.frame.height/4
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        9.9
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0.1
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        dataSource.removeOrder(at: indexPath.section)
        cartTableView.deleteSections([indexPath.section], with: .left)
        checkoutButton.setActivation(onState:  dataSource.getOrdersArrayCount() == 0 ? .Disabled : .Enabled)
    }
}
