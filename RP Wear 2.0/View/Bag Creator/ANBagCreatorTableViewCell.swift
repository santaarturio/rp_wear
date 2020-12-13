//
//  ANBagCreatorTableViewCell.swift
//  RP Wear 2.0
//
//  Created by Macbook Pro  on 12.11.2020.
//

import UIKit
//MARK: CellDelegate
protocol BagCreatorTableViewCellDelegate: NSObject {
    func bagCreatorTableViewCellSelectButtonTapped(at: Int)
    func sliderShouldOpenFlagChanged(onCellWithIndex: Int, newFlag: Bool)
}

class ANBagCreatorTableViewCell: UITableViewCell {
    public weak var delegate: BagCreatorTableViewCellDelegate?
    
    public var index = 0
    private var sliderShouldOpen: Bool = false
    
    @IBOutlet weak var imageButtonBackgroundImageView: UIImageView!
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var selectButton: ANButton!
    @IBOutlet weak var selectButtonBottomConstraint: NSLayoutConstraint!
    
    //MARK: cell view did load
    override func awakeFromNib() {
        super.awakeFromNib()
        
        editImageButtonImageView()
        editDescriptionTextView()
        editSelectButton()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - UISetup
    private func editImageButtonImageView() { imageButtonBackgroundImageView.layer.cornerRadius = 22.5 }
    private func editDescriptionTextView() { descriptionTextView.layer.cornerRadius = 22.5 }
    private func editSelectButton() {
        selectButton.setupWithBorder()
        selectButton.setActivation(onState: .Invisible)
    }
    
    //MARK: - reusable "init"
    public func refresh(imageName: String, descriptionText: String, sliderState: Bool) {
        imageButtonBackgroundImageView.image = UIImage(named: imageName)
        descriptionTextView.text = descriptionText
        sliderShouldOpen = sliderState
        
        moveSubviews(withState: sliderShouldOpen)
    }
    
    //MARK: - IBAction
    @IBAction func imageButtonTouchedDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) { self.transform = .init(scaleX: 0.8, y: 0.8) }
    }
    @IBAction func imageButtonTouchedUp(_ sender: UIButton) {
        sliderShouldOpen = !sliderShouldOpen
        delegate?.sliderShouldOpenFlagChanged(onCellWithIndex: index, newFlag: sliderShouldOpen)
        UIView.animate(withDuration: 0.5) { [self] in
            moveSubviews(withState: sliderShouldOpen)
            self.transform = .identity
        }
    }
    @IBAction func selectButtonTapped(_ sender: ANButton) { delegate?.bagCreatorTableViewCellSelectButtonTapped(at: index) }
    
    //MARK: - Move Subviews
    private func moveSubviews(withState open: Bool) {
        if open {
            // offSet imageView & imageButton by X to the left
            imageButtonBackgroundImageView.transform = .init(translationX: -(imageButtonBackgroundImageView.frame.width * 0.51), y: 0.0)
            imageButton.transform = .init(translationX: -(imageButton.frame.width * 0.51), y: 0.0)
            
            // offSet textView by X to the right
            descriptionTextView.transform = .init(translationX: (descriptionTextView.frame.width * 0.51), y: 0.0)
            
            // offSet selectButton by Y up
            selectButtonBottomConstraint.priority = UILayoutPriority(rawValue: 500)
            self.layoutIfNeeded()
            
            selectButton.setActivation(onState: .Enabled)
        } else {
            // offSet all views back
            imageButtonBackgroundImageView.transform = .identity
            imageButton.transform = .identity
            descriptionTextView.transform = .identity
            
            selectButtonBottomConstraint.priority = selectButtonBottomConstraint.priority.rawValue == 500 ? UILayoutPriority(rawValue: 1000) : UILayoutPriority(rawValue: 500)
            self.layoutIfNeeded()
            
            selectButton.setActivation(onState: .Invisible)
        }
    }
}
