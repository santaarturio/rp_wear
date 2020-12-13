//
//  ANQuizViewController.swift
//  RP Wear 2.0
//
//  Created by Macbook Pro  on 27.11.2020.
//

import UIKit
import Koloda

class ANQuizViewController: DefaultViewController {
    
    private let dataSource = ANQuizVcDataSource()
    private let cellIdentifier = String(describing: UITableViewCell.self)
    private let headerIdentifier = String(describing: ANQuizVcTableViewHeader.self)
    private let headerHeight: CGFloat = 80.0
    private var currentAnswer = 0
    
    @IBOutlet weak var myProgressView: UIProgressView!
    @IBOutlet weak var kolodaView: KolodaView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kolodaView.dataSource = self
        kolodaView.delegate = self
    }
    //MARK: - IBAction
    @IBAction func replyButtonTapped(_ sender: UIBarButtonItem) {
        kolodaView.revertAction(direction: .right)
    }
    @IBAction func refreshButtonTapped(_ sender: UIBarButtonItem) {
        kolodaView.resetCurrentCardIndex()
        dataSource.clearAnswers()
    }
    //MARK: - Support
    private func configureQuizTableView(with index: Int) -> ANTableView {
        let tableView = ANTableView(frame: CGRect(), style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.register(ANQuizVcTableViewHeader.self, forHeaderFooterViewReuseIdentifier: headerIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.setup(with: index)
        tableView.isScrollEnabled = false
        return tableView
    }
    private func showResult() {
        let identifier = String(describing: ANResultViewController.self)
        let storyboard = UIStoryboard(name: identifier, bundle: nil)
        guard let resultVC = storyboard.instantiateViewController(withIdentifier: identifier) as? ANResultViewController else { return }
        let bag = dataSource.getResultOfQuiz()
        resultVC.dataSource.put(bag: bag)
        navigationController?.pushViewController(resultVC, animated: true)
    }
}
//MARK: - UITableViewDelegate + DataSource
extension ANQuizViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tableView = tableView as? ANTableView else { return 0 }
        return dataSource.getNumberOfAnswers(byQuestionIndex: tableView.index)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableView = tableView as? ANTableView else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = dataSource.getAnswer(byQuestionIndex: tableView.index, at: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard
            let tableView = tableView as? ANTableView, let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerIdentifier) as? ANQuizVcTableViewHeader else { return nil }
        header.setLabelsText(text: dataSource.getQuestion(at: tableView.index))
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        headerHeight
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let tableView = tableView as? ANTableView else { return 0.0 }
        return (tableView.frame.height - headerHeight) / CGFloat(dataSource.getNumberOfAnswers(byQuestionIndex: tableView.index))
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentAnswer = indexPath.row
        kolodaView.swipe(.right, force: true)
    }
}
//MARK: - KolodaViewDelegate + DataSource
extension ANQuizViewController: KolodaViewDataSource, KolodaViewDelegate {
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        dataSource.getNumberOfQuestions()
    }
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        configureQuizTableView(with: index)
    }
    func koloda(_ koloda: KolodaView, shouldDragCardAt index: Int) -> Bool {
        false
    }
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        dataSource.insertAnswer(currentAnswer, at: index)
    }
    func koloda(_ koloda: KolodaView, didShowCardAt index: Int) {
        myProgressView.setProgress(Float(index) / Float(dataSource.getNumberOfQuestions()), animated: true)
    }
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        kolodaView.resetCurrentCardIndex()
        showResult()
        dataSource.clearAnswers()
    }
}
