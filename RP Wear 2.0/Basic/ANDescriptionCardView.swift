import TinyConstraints
import UIKit

protocol ANDescriptionCardViewDelegate: NSObject {
    func viewShouldBeClosed()
}

class ANDescriptionCardView: UIView {
    public weak var delegate: ANDescriptionCardViewDelegate?

    private var tapGesture = UITapGestureRecognizer()
    private var closeButton = UIButton(type: .close)
    private var myImageView = UIImageView()
    private var descriptionLabel = UILabel()
    //MARK: - public Setup method
    public func setup(imageName: String, description text: String) {
        if let image = UIImage(named: imageName) { myImageView.image = image }
        descriptionLabel.text = text
        configureUI()
    }

    //MARK: - Configure
    private func configureUI() {
        backgroundColor = .white
        layer.cornerRadius = 15
        
        closeButton.addTarget(self, action: #selector(viewShouldBeClosed(sender:)), for: .touchUpInside)
        addSubview(closeButton)
        
        myImageView.contentMode = .scaleAspectFit
        addSubview(myImageView)
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.layer.cornerRadius = 15
        descriptionLabel.clipsToBounds = true
        descriptionLabel.backgroundColor = .white
        addSubview(descriptionLabel)
        
        createConstraints()
        addTapGesture()
    }
    private func createConstraints() {
        closeButton.topToSuperview(offset: 8.0)
        closeButton.rightToSuperview(offset: -8.0)
        closeButton.heightToSuperview(multiplier: 0.05)
        closeButton.widthToHeight(of: closeButton)

        myImageView.topToBottom(of: closeButton)
        myImageView.leftToSuperview(offset: 8)
        myImageView.rightToSuperview(offset: -8)
        myImageView.heightToSuperview(multiplier: 0.75)

        descriptionLabel.topToBottom(of: myImageView)
        descriptionLabel.edgesToSuperview(excluding: .top, insets: .uniform(8.0))
    }
    private func addTapGesture() {
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(sender:)))
        addGestureRecognizer(tapGesture)
    }
    //MARK: - Action
    @objc private func viewTapped(sender: UITapGestureRecognizer) {
        delegate?.viewShouldBeClosed()
        removeGestureRecognizer(tapGesture)
    }
    @objc private func viewShouldBeClosed(sender: UIButton) {
        delegate?.viewShouldBeClosed()
        removeGestureRecognizer(tapGesture)
    }
}
