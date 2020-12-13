//
//  ANResultViewController.swift
//  RP Wear 2.0
//
//  Created by Macbook Pro  on 20.11.2020.
//

import UIKit

class ANResultViewController: DefaultViewController {
    public let dataSource = ANResultVcDataSource()
    private let cellIdentifier = String(describing: ANResultCollectionViewCell.self)
    private var tappedCell = ANResultCollectionViewCell()
    private var descriptionView = ANDescriptionCardView()
    lazy private var constraintsToView = descriptionView.edgesToSuperview(insets: .uniform(20), isActive: false, usingSafeArea: true)
    @IBOutlet weak var myProgressView: ANProgressView!
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var descriptionTitleLabel: ANLabel!
    @IBOutlet weak var descriptionBodyLabel: ANLabel!
    @IBOutlet weak var addToCartButton: ANButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        configureLabels()
        addToCartButton.setup()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        myProgressView.complete()
    }
    //MARK: - Setup
    private func configureCollectionView() {
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
    }
    private func configureLabels() {
        descriptionTitleLabel.setup()
        descriptionBodyLabel.setup()
        topLabel.text = dataSource.getTopLabelText()
        descriptionTitleLabel.text = dataSource.getDescriptionTitle()
        descriptionBodyLabel.text = dataSource.getDescriptionText()
    }
    
    //MARK: - Description View
    private func presentDescription(presentationMode: PresentationMode) {
        let subviews = view.subviews
        let constraintsToCell = descriptionView.edges(to: tappedCell, isActive: false)
        
        switch presentationMode {
        case .Show:
            descriptionView.delegate = self
            view.addSubview(descriptionView)
            constraintsToCell.activate(); view.layoutIfNeeded()
            constraintsToCell.deActivate()
            constraintsToView.activate()
            
            UIView.animate(withDuration: 0.5) { [self] in
                view.layoutIfNeeded()
                view.backgroundColor = .white
                for subview in subviews { subview.alpha = 0.0 }
                descriptionView.backgroundColor = DefaultViewController().view.backgroundColor
            }
        case .Hide:
            constraintsToView.deActivate()
            constraintsToCell.activate()
            
            UIView.animate(withDuration: 0.5) { [self] in
                view.layoutIfNeeded()
                view.backgroundColor = DefaultViewController().view.backgroundColor
                for subview in subviews { subview.alpha = 1.0 }
                descriptionView.backgroundColor = .white
            }
            completion: { _ in self.descriptionView.removeFromSuperview() }
        }
    }
    
    //MARK: - Action
    @IBAction func addToCartButtonTapped(_ sender: ANButton) {
        dataSource.putBagToCart()
    }
}

//MARK: - Delegates
extension ANResultViewController: UICollectionViewDelegate, ANDescriptionCardViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = myCollectionView.cellForItem(at: indexPath) as? ANResultCollectionViewCell else { return }
        tappedCell = cell
        switch indexPath.item {
        case 0: descriptionView.setup(imageName: dataSource.getFullBagImageName(), description: " ")
        case 1: descriptionView.setup(imageName: dataSource.getBagPrintImageName(), description: " ")
        case 2: descriptionView.setup(imageName: dataSource.getCleanBagImageName(), description: " ")
        default: break
        }
        descriptionView.delegate = self
        presentDescription(presentationMode: .Show)
    }
    func viewShouldBeClosed() {
        presentDescription(presentationMode: .Hide)
    }
}
//MARK: - UICollectionViewDataSource
extension ANResultViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ANResultCollectionViewCell else { return UICollectionViewCell() }
        switch indexPath.item {
        case 0: cell.configureWith(imageName: dataSource.getFullBagImageName())
        case 1: cell.configureWith(imageName: dataSource.getBagPrintImageName())
        case 2: cell.configureWith(imageName: dataSource.getCleanBagImageName())
        default: break
        }
        return cell
    }
}
//MARK: - UICollectionViewDelegateFlowLayout
extension ANResultViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = myCollectionView.frame.width/2 - 3.0
        var cellHeight = CGFloat()
        if indexPath.item == 0 { cellHeight = myCollectionView.frame.height } else { cellHeight = myCollectionView.frame.height/2 - 3.0 }
        return CGSize(width: cellWidth,
                      height: cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
}
