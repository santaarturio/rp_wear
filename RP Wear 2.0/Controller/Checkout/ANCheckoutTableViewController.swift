//
//  ANCheckoutTableViewController.swift
//  RP Wear 2.0
//
//  Created by Macbook Pro  on 23.11.2020.
//

import UIKit

class ANCheckoutTableViewController: UITableViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var postNumberTextField: UITextField!
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet weak var callOrNotSegment: UISegmentedControl!
    @IBOutlet weak var makeOrderButton: ANButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeOrderButton.setup()
        checkUserDefaults()
    }
    
    //MARK: - UISetup
    private func checkUserDefaults() {
        for textField in textFields {
            guard let text = UserDefaults.standard.value(forKey: textField.placeholder ?? textField.description) as? String else { return }
            textField.text = text
        }
        if allTextFieldsHaveData() { makeOrderButton.setActivation(onState: .Enabled) } else {
            makeOrderButton.setActivation(onState: .Disabled)
            nameTextField.becomeFirstResponder()
        }
    }
    //MARK: - Action
    @IBAction func makeOrderButtonTapped(_ sender: ANButton) {
        for textField in textFields { UserDefaults.standard.setValue(textField.text, forKey: textField.placeholder ?? textField.description) }
        let newOrder = createNewOrder()
        print(newOrder)
        //send newOrder to @gmail.com or Telegram
        showAlert()
    }
    //MARK: - orderCreator
    private func createNewOrder() -> String {
        var message = "Новый заказ:\n\n"
        for index in 0..<CartManager.shared.getOrdersArrayCount(){
            let item = CartManager.shared.getOrder(at: index)
            let itemMessage = "\(item.name)\n\(item.description)\n\"Цена: \(item.price)\"\n"
            message.append(contentsOf: itemMessage)
        }
        let customerData = """

Данные о покупателе:

Имя и Фамилия - \(nameTextField.text ?? "no name")
Номер телефона - \(phoneNumberTextField.text ?? "no number"), \(callOrNotSegment.selectedSegmentIndex == 0 ? "можно позвонить!" : "не звонить!")
НП: \(cityTextField.text ?? "no city"), \(postNumberTextField.text ?? "no postNumder")
"""
        message.append(contentsOf: customerData)
        return message
    }
    //MARK: - Support
    private func allTextFieldsHaveData() -> Bool {
        for textField in textFields { guard let text = textField.text, !text.isEmpty else { return false } }
        return true
    }
    private func showAlert() {
        let alertController = UIAlertController(title: "Готово!", message: "Ваш заказ отправлен в обработку", preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК", style: .default) { [self] (_) in
            navigationController?.popViewController(animated: true)
        }
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}
//MARK: - UITextFieldDelegate
extension ANCheckoutTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let index = textFields.firstIndex(of: textField) else { return true }
        let _ = index < (textFields.count - 1) ? textFields[index + 1].becomeFirstResponder() :
            textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        makeOrderButton.setActivation(onState: allTextFieldsHaveData() ? .Enabled : .Disabled)
    }
}
