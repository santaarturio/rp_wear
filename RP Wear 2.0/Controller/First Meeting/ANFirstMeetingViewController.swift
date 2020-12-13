
import UIKit

class ANFirstMeetingViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    private var pageViewController = UIPageViewController()
    
    private let imageNamesArray = ["welcome1", "welcome2", "welcome3", "welcome4"]
    private var viewControllersArray = [ANFirstMeetingImageViewController]()
    
    private var currentVcIndex = 0 {
        willSet { currentVcIndexValueChanged(onNewValue: newValue) }
    }
    @IBOutlet weak var myPageControl: UIPageControl!
    @IBOutlet weak var backButton: ANButton!
    @IBOutlet weak var nextButton: ANButton!
    @IBOutlet weak var doneButton: ANButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButtons()
        fillViewControllersArray()
        configureMyPageControl()
        configurePageViewController()
    }
    //MARK: - UISetup
    private func setupButtons() {
        backButton.setup()
        nextButton.setup()
        doneButton.setup()
    }
    private func configureMyPageControl() {
        myPageControl.numberOfPages = viewControllersArray.count
        myPageControl.currentPage = currentVcIndex
    }
    
    //MARK: - Setup
    private func fillViewControllersArray() {
        for index in 0..<imageNamesArray.count {
            guard let imageVC = storyboard?.instantiateViewController(identifier: String(describing: ANFirstMeetingImageViewController.self)) as? ANFirstMeetingImageViewController else { return }
            imageVC.image = UIImage(named: imageNamesArray[index])
            imageVC.index = index
            viewControllersArray.append(imageVC)
        }
    }
    private func configurePageViewController() {
        pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                  navigationOrientation: .horizontal,
                                                  options: nil)
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        
        contentView.addSubview(pageViewController.view)
        
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        let views: [String: UIView] = ["pageView": pageViewController.view!]
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[pageView]-0-|",
                                                                  options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                                  metrics: nil,
                                                                  views: views))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[pageView]-0-|",
                                                                  options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                                  metrics: nil,
                                                                  views: views))
        
        pageViewController.setViewControllers([viewControllersArray[0]],
                                              direction: .forward, animated: true,
                                              completion: nil)
    }
    
    //MARK: - Action
    @IBAction func myPageControlTapped(_ sender: UIPageControl) {
        currentVcIndex = sender.currentPage
    }
    @IBAction func backButtonTapped(_ sender: UIButton) {
        currentVcIndex -= 1
    }
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        currentVcIndex += 1
    }
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        let userDefaults = UserDefaults.standard
        
        userDefaults.set(true, forKey: "haveSeenTutorial")
        userDefaults.synchronize()
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Index handler
    private func currentVcIndexValueChanged(onNewValue index: Int) {
        setVC(index: index, isForward: index > currentVcIndex)
        switch index {
        case 0:
            UIView.animate(withDuration: 0.3) { [self] in
                myPageControl.currentPage = index
                backButton.setActivation(onState: .Disabled)
                nextButton.setActivation(onState: .Enabled)
                doneButton.setActivation(onState: .Invisible)
            }
        case 1..<viewControllersArray.count - 1:
            UIView.animate(withDuration: 0.3) { [self] in
                myPageControl.currentPage = index
            }
            backButton.setActivation(onState: .Enabled)
            nextButton.setActivation(onState: .Enabled)
            doneButton.setActivation(onState: .Invisible)
        case viewControllersArray.count - 1:
            UIView.animate(withDuration: 0.3 ) { [self] in
                myPageControl.currentPage = index
                backButton.setActivation(onState: .Invisible)
                nextButton.setActivation(onState: .Invisible)
                doneButton.setActivation(onState: .Enabled)
            }
        default: break
        }
    }
    private func setVC(index: Int, isForward: Bool) {
        pageViewController.setViewControllers([viewControllersArray[index]],
                                              direction: isForward ? .forward : .reverse,
                                              animated: true, completion: nil)
    }
}

//MARK: - UIPageViewControllerDelegate + DataSource
extension ANFirstMeetingViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? ANFirstMeetingImageViewController,
              let index = viewControllersArray.firstIndex(of: viewController),
              index > 0 else { return nil }
        return viewControllersArray[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? ANFirstMeetingImageViewController,
              let index = viewControllersArray.firstIndex(of: viewController),
              index < viewControllersArray.count - 1 else { return nil }
        return viewControllersArray[index + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed && finished,
              let currentVC = pageViewController.viewControllers?.first as? ANFirstMeetingImageViewController else { return }
        currentVcIndex = currentVC.index ?? 0
    }
}
