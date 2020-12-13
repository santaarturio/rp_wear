//
//  TestViewController.swift
//  RP Wear 2.0
//
//  Created by Macbook Pro  on 11.11.2020.
//

import UIKit

class TestViewController: UIViewController {
    
    @IBOutlet var imagesArray: [UIImageView]!
    @IBOutlet weak var myScrollView: UIScrollView!
    
    @IBOutlet weak var myPageControl: UIPageControl!
    @IBOutlet weak var backButton: ANButton!
    @IBOutlet weak var nextButton: ANButton!
    @IBOutlet weak var doneButton: ANButton!
    
    private var currentPageIndex = 0 {
        didSet { indexHandler(pageIndex: currentPageIndex) }
    }
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollView()
        setupButtons()
        setupPageControl()
    }
    
    //MARK: - UISetup
    private func setupScrollView() {
        myScrollView.delegate = self
        myScrollView.layer.cornerRadius = 15
    }
    private func setupButtons() {
        backButton.setup()
        backButton.setActivation(onState: .Disabled)
        nextButton.setup()
        nextButton.setActivation(onState: .Enabled)
        doneButton.setup()
        doneButton.setActivation(onState: .Invisible)
    }
    private func setupPageControl() { myPageControl.numberOfPages = imagesArray.count }
    
    //MARK: - IBActions
    @IBAction func pageControlTapped(_ sender: UIPageControl) {
        currentPageIndex = sender.currentPage
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        if currentPageIndex != 0 { currentPageIndex -= 1 }
    }
    @IBAction func nextButtonTapped(_ sender: Any) {
        currentPageIndex += 1
    }
    @IBAction func doneButtonTapped(_ sender: Any) {
        userDefaults.set(true, forKey: "haveSeenTutorial")
        userDefaults.synchronize()
        self.dismiss(animated: true, completion: nil)
    }
    //MARK: - Private
    private func indexHandler(pageIndex index: Int) {
        switch index {
        case 0:
            myScrollView.scrollTo(horizontalPage: index, animated: true)
            
            myPageControl.currentPage = index
            backButton.setActivation(onState: .Disabled)
            nextButton.setActivation(onState: .Enabled)
            doneButton.setActivation(onState: .Invisible)
            
        case 1..<imagesArray.count - 1:
            myScrollView.scrollTo(horizontalPage: index, animated: true)
            
            myPageControl.currentPage = index
            backButton.setActivation(onState: .Enabled)
            nextButton.setActivation(onState: .Enabled)
            doneButton.setActivation(onState: .Invisible)
            
        case imagesArray.count - 1:
            myScrollView.scrollTo(horizontalPage: index, animated: true)
            myPageControl.currentPage = index
            
            UIView.animate(withDuration: 0.5) { [self] in
                backButton.setActivation(onState: .Invisible)
                nextButton.setActivation(onState: .Invisible)
                doneButton.setActivation(onState: .Enabled)
            }
        default: break
        }
    }
}

extension TestViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
        currentPageIndex = Int(pageIndex)
    }
}
