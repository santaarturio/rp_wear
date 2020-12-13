//
//  ANFirstMeetingPageViewController.swift
//  RP Wear 2.0
//
//  Created by Macbook Pro  on 10.11.2020.
//

import UIKit

class ANFirstMeetingPageViewController: UIPageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    /*
    lazy var firstMeetingVCArray: [ANFirstMeetingImageViewController] = {
        
        var vcArray = [ANFirstMeetingImageViewController]()
        for name in imageNamesArray {
            let newVC = ANFirstMeetingImageViewController(imageName: name)
            vcArray.append(newVC)
        }
        return vcArray
    }()
    
    override func viewDidLoad() {
        delegate = self
        dataSource = self
        setViewControllerFrom(index: 0)
    }
    
    public func setViewControllerFrom(index: Int) {
        self.setViewControllers([firstMeetingVCArray[index]],
                                direction: .forward,
                                animated: true,
                                completion: nil)
        print("seted")
    }
}

extension ANFirstMeetingPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let viewController = viewController as? ANFirstMeetingImageViewController else { return nil }
        if let index = firstMeetingVCArray.firstIndex(of: viewController) {
            
            if index > 0 {
                return firstMeetingVCArray[index - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        guard let viewController = viewController as? ANFirstMeetingImageViewController else { return nil }
        if let index = firstMeetingVCArray.firstIndex(of: viewController) {
            
            if index < (firstMeetingVCArray.count - 1) {
                return firstMeetingVCArray[index + 1]
            }
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return imageNamesArray.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
 */
}
