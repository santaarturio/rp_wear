//
//  ANFirstMeetingImageViewController.swift
//  RP Wear 2.0
//
//  Created by Macbook Pro  on 11.11.2020.
//

import UIKit

class ANFirstMeetingImageViewController: UIViewController {
    
    public var index: Int?
    public var image: UIImage?

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = image
    }
}
