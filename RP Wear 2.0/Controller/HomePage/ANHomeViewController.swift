//
//  ANHomeViewController.swift
//  RP Wear 2.0
//
//  Created by Macbook Pro  on 10.11.2020.
//

import AVKit
import SafariServices
import UIKit

class ANHomeViewController: DefaultViewController {
    
    private let dataSource = ANHomeVcDataSource()
    private var player: AVPlayer!
    private var playerLayer: AVPlayerLayer!
    private var screenIsCurrent = false
    
    @IBOutlet weak var videoBackgroundView: UIView!
    @IBOutlet var allImages: [UIImageView]!
    @IBOutlet var allLabels: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editImages()
        editLabels()
        launchVideoView()
        checkUserDefaults()
    }
    
    //MARK: - UISetup
    private func editImages() {
        for image in allImages { image.layer.cornerRadius = 7.5 }
    }
    private func editLabels() {
        for index in 0..<allLabels.count {
            allLabels[index].text = dataSource.getLabelText(at: index)
        }
    }
    private func launchVideoView() {
        guard
            let url = dataSource.getVideoURL() else { return }
        player = AVPlayer(url: url)
        player.volume = 0.0
        
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = videoBackgroundView.bounds
        playerLayer.videoGravity = .resizeAspectFill
        
        videoBackgroundView.layer.addSublayer(playerLayer)
        
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(playerDidFinishPlaying(sender:)),
                         name: .AVPlayerItemDidPlayToEndTime,
                         object: nil)
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(sceneWillEnterForground(sender:)),
                         name: UIApplication.willEnterForegroundNotification,
                         object: nil)
    }
    
    //MARK: - Play and pause video
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        screenIsCurrent = true
        player.play()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        screenIsCurrent = false
        player.pause()
    }
    
    //MARK: - Action
    @objc private func playerDidFinishPlaying(sender: NSNotification) {
        player.currentItem?.seek(to: .zero, completionHandler: nil)
        player.play()
    }
    @objc private func sceneWillEnterForground(sender: NSNotification) {
        if screenIsCurrent { player.play() }
    }
    //MARK: - IBAction
    @IBAction func instaButtonTapped(_ sender: UIButton) {
        guard let url = dataSource.getInstaURL() else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated: true, completion: nil)
        }
    }
    
    //MARK: - User defaults
    private func checkUserDefaults() {
                UserDefaults.standard.removeObject(forKey: "haveSeenTutorial")
        guard
            UserDefaults.standard.object(forKey: "haveSeenTutorial") == nil else { return }
        let identifier = String(describing: ANFirstMeetingViewController.self)
        let storyboard = UIStoryboard(name: identifier, bundle: nil)
        if let nextVC = storyboard.instantiateViewController(identifier: identifier) as? ANFirstMeetingViewController {
            present(nextVC, animated: true, completion: nil)
        }
    }
}

