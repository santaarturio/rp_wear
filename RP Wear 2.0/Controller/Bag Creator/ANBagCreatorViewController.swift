//
//  ANBagCreatorViewController.swift
//  RP Wear 2.0
//
//  Created by Macbook Pro  on 12.11.2020.
//

import UIKit

class ANBagCreatorViewController: DefaultViewController {
    
    private let dataSource = ANBagCreatorVcDataSource()
    private let cellIdentifier = String(describing: ANBagCreatorTableViewCell.self)
    lazy private var cellsSliderStateArray = [Bool](repeating: false, count: dataSource.getNumberOfImages())
    
    @IBOutlet weak var myProgressView: ANProgressView!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var nextStepButton: ANButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myProgressView.setup()
        setupNextStepButton()
    }
    
    //MARK: - UISetup
    private func setupNextStepButton() {
        nextStepButton.setup()
        nextStepButton.setActivation(onState: .Disabled)
    }
    
    //MARK: - IBAction
    @IBAction func nextStepButtonTapped(_ sender: ANButton) {
        let identifier = String(describing: ANImageBagCreatorViewController.self)
        let storyboard = UIStoryboard(name: identifier, bundle: nil)
        
        guard let nextVC = storyboard.instantiateViewController(identifier: identifier) as? ANImageBagCreatorViewController else { return }
        nextVC.dataSource.put(bag: dataSource.getBag())
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

//MARK: - UITableViewDelegate + DataSource
extension ANBagCreatorViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        myTableView.frame.height * 0.6
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.getNumberOfImages()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? ANBagCreatorTableViewCell else { return UITableViewCell() }
        
        let index = indexPath.row
        cell.index = index
        cell.refresh(imageName: dataSource.getImageName(at: index),
                     descriptionText: dataSource.getImageDescription(at: index),
                     sliderState: cellsSliderStateArray[index])
        cell.delegate = self
        return cell
    }
}

//MARK: - TableViewCellDelegate
extension ANBagCreatorViewController: BagCreatorTableViewCellDelegate {
    func sliderShouldOpenFlagChanged(onCellWithIndex index: Int, newFlag state: Bool) {
        cellsSliderStateArray[index] = state
    }
    func bagCreatorTableViewCellSelectButtonTapped(at index: Int) {
        dataSource.createBag(at: index)
        nextStepButton.setActivation(onState: .Enabled)
        myProgressView.complete()
    }
}
