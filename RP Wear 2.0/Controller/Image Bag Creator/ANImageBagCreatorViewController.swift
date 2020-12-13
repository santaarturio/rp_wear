import UIKit
import TinyConstraints

public enum PresentationMode {
    case Show, Hide
}

class ANImageBagCreatorViewController: DefaultViewController {
    public let dataSource = ANImageBagCreatorVcDataSource()
    private let cellIdentifier = String(describing: ANImageBagCreatorCollectionViewCell.self)
    private let draggedView = UIImageView()
    private let descriptionView = ANDescriptionCardView()
    private var tappedCell = ANImageBagCreatorCollectionViewCell()
    private var panGesture = UIPanGestureRecognizer()
    private var imageCanMove = false
    private var nextStepButtonAvailible = false
    lazy private var constraintsToView = descriptionView.edgesToSuperview(insets: .uniform(20), isActive: false, usingSafeArea: true)
    
    @IBOutlet weak var myProgressView: ANProgressView!
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var nextStepButton: ANButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myProgressView.setup()
        configureTopImageView()
        configureCollectionView()
        configureNextStepButton()
        configureGestures()
    }
    
    //MARK: - ConfigureUI
    private func configureTopImageView() {
        topImageView.layer.cornerRadius = 15
        let bag = dataSource.getBag()
        if bag.bagImage.isEmpty { topImageView.image = UIImage(named: bag.cleanBagImageName)
        } else { topImageView.image = UIImage(named: bag.fullBag) }
    }
    private func configureCollectionView() { myCollectionView.layer.cornerRadius = 7.5 }
    private func configureNextStepButton() {
        nextStepButton.setup()
        nextStepButton.setActivation(onState: .Disabled)
    }
    private func configureGestures() {
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureSelector(sender:)))
        view.addGestureRecognizer(panGesture)
    }
    
    //MARK: - Dragged View
    private func setupDraggedViewWith(imageName: String) {
        if view.subviews.contains(draggedView) { draggedView.removeFromSuperview() }
        
        draggedView.image = UIImage(named: imageName)
        draggedView.contentMode = .scaleAspectFit
        view.addSubview(draggedView)
        
        draggedView.edges(to: tappedCell)
        draggedView.alpha = 0.0
    }
    private func removeDraggedView() {
        draggedView.removeFromSuperview()
        imageCanMove = false
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
                nextStepButtonAvailible ? nextStepButton.setActivation(onState: .Enabled) : nextStepButton.setActivation(onState: .Disabled)
                descriptionView.backgroundColor = .white
            }
            completion: { _ in self.descriptionView.removeFromSuperview() }
        }
    }
    //MARK: - IBAction
    @IBAction func nextStepButtonTapped(_ sender: ANButton) {
        let identifier = String(describing: ANResultViewController.self)
        let storyboard = UIStoryboard(name: identifier, bundle: nil)
        guard let nextVC = storyboard.instantiateViewController(identifier: identifier) as? ANResultViewController else { return }
        nextVC.navigationItem.title = "Шаг 3"
        nextVC.dataSource.put(bag: dataSource.getBag())
        navigationController?.pushViewController(nextVC, animated: true)
    }
    //MARK: - Action
    @objc func panGestureSelector(sender: UIPanGestureRecognizer) {
        guard imageCanMove == true else { return }
        let currentPoint = sender.location(in: view)
        switch sender.state {
        case .began: imageCanMove = true 
        case .changed:
            draggedView.alpha = 1.0
            draggedView.center = currentPoint
            UIView.animate(withDuration: 0.15) { [self] in
                if topImageView.frame.contains(currentPoint) {
                    topImageView.transform = .init(scaleX: 0.95, y: 0.95)
                } else { topImageView.transform = .identity }
            }
        case .ended where topImageView.frame.contains(currentPoint):
            let index = myCollectionView.indexPath(for: tappedCell)?.row ?? 0
            dataSource.configureBag(at: index)

            configureTopImageView()
            topImageView.transform = .identity
            myProgressView.complete()
            nextStepButtonAvailible = true
            nextStepButton.setActivation(onState: .Enabled)
            removeDraggedView()
        default:
            removeDraggedView()
            topImageView.transform = .identity
        }
    }
}
//MARK: - CollectionViewDataSource
extension ANImageBagCreatorViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.getNumberOfImages()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ANImageBagCreatorCollectionViewCell else { return UICollectionViewCell() }
        cell.configureWith(imageName: dataSource.getImageName(at: indexPath.item))
        return cell
    }
}
//MARK: - CollectionViewDelegate
extension ANImageBagCreatorViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        guard
            let cell = collectionView.cellForItem(at: indexPath) as? ANImageBagCreatorCollectionViewCell else { return }
        myCollectionView.panGestureRecognizer.minimumNumberOfTouches = 2
        tappedCell = cell
        setupDraggedViewWith(imageName: dataSource.getImageName(at: indexPath.item))
        imageCanMove = true
    }
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        myCollectionView.panGestureRecognizer.minimumNumberOfTouches = 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        removeDraggedView()
        let index = indexPath.item
        descriptionView.setup(imageName: dataSource.getImageName(at: index),
                              description: dataSource.getImageDescription(at: index))
        presentDescription(presentationMode: .Show)
    }
}
//MARK: CardViewDelegate
extension ANImageBagCreatorViewController: ANDescriptionCardViewDelegate {
    func viewShouldBeClosed() {
        presentDescription(presentationMode: .Hide)
    }
}
//MARK: DelegateFlowLayout
extension ANImageBagCreatorViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        /*
         width = (x / y - z)
         x - superview`s width
         y - count if items in row
         z - interitem spacing * (y - 1) / y
         
         width/height = 3/4
         height = width * 4 / 3
         */
        let cellWidth = myCollectionView.frame.width/4 - 4.5
        let cellHeight = cellWidth * 4 / 3
        
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
