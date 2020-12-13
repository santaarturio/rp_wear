//
//  ANHomePageViewController.swift
//  RP Wear 2.0
//
//  Created by Macbook Pro  on 09.11.2020.
//
import AVKit
import SafariServices
import UIKit

class ANHomePageViewController: UIViewController {
    
    private var player: AVPlayer!
    private var timer = Timer()
    @IBOutlet weak var videoBackgroundView: UIView!
    
    @IBOutlet var allImages: [UIImageView]!
    @IBOutlet weak var whatInsideLabel: UILabel!
    @IBOutlet weak var howToPaintLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editImages()
        editTextLabels()
        
        
        let identifier = String(describing: ANFirstMeetingViewController.self)
        let storyboard = UIStoryboard(name: identifier, bundle: nil)
        if let nextVC = storyboard.instantiateViewController(identifier: identifier) as? ANFirstMeetingViewController {

            present(nextVC, animated: true, completion: nil)
            print("presented")
        }
        
    }
    
    //MARK: - upgrate UI
    private func editImages() {
        for image in allImages {
            image.layer.cornerRadius = 7
        }
    }
    private func editTextLabels() {
        whatInsideLabel.text = """
              ✨ Экосумку с готовым контуром
              ✨ Набор премиальных красок по ткани
              ✨ Кисти для рисования
              ✨ Интересную инструкцию
              💥 Приятный бонус*
            """
        howToPaintLabel.text = """
              ✨ Готовый контур на сумке поможет не нарисовать лишнего
              ✨ Инструкция с примером готового рисунка станет Вашим путеводителем в этом увлекательном процессе
              💥 ВАЖНО! Не забудьте сделать небольшой перерыв на *внимательный осмотр бонуса
            """
    }
    
    //MARK: - Launch and repit top video
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        launchVideoView()
        launchRepiatingVideoTimer()
    }
    
    private func launchVideoView() {
        guard let path = Bundle.main.path(forResource: "vika", ofType: "MOV") else { return }
        let url = URL(fileURLWithPath: path)
        player = AVPlayer(url: url)
        
        let layer = AVPlayerLayer(player: player)
        layer.frame = videoBackgroundView.bounds
        layer.videoGravity = .resizeAspectFill
        videoBackgroundView.layer.addSublayer(layer)
        player.volume = 0.0
        
        player.play()
    }
    private func launchRepiatingVideoTimer() {
        if let duration = player.currentItem?.asset.duration.seconds {
            timer = Timer.scheduledTimer(timeInterval: duration, target: self, selector: #selector(repiatingVideoTimerSelector), userInfo: nil, repeats: true)
        }
    }
    @objc private func repiatingVideoTimerSelector() {
        launchVideoView()
    }
    
    //MARK: - Switch Off top tideo
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        stopVideoAndTimer()
    }
    
    func stopVideoAndTimer() {
        timer.invalidate()
        player.pause()
    }
    
    //MARK: - Instagram referance
    @IBAction func instaButtonTapped(_ sender: UIButton) {
        if let url = URL(string: "https://www.instagram.com/really_pretty_wear/") {
            let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated: true, completion: nil)
        }
    }
}
