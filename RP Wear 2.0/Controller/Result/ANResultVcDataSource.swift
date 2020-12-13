//
//  ANResultVcDataSource.swift
//  RP Wear 2.0
//
//  Created by Macbook Pro  on 03.12.2020.
//

import Foundation

class ANResultVcDataSource {
    //MARK: - Properties
    private var bag = BagModel()
    private let topLabelText = "Отличный выбор!"
    lazy private var descriptionTitle = "Поздравляем, твой выбор: сумка цвета \"\(bag.bagColor)\", принт - \"\(bag.bagImage)\"!"
    private let descriptionText = "  Команда RP Wear начнет собирать Ваш заказ сразу же после его оформления в разделе \"Корзина\".\n  P.s. После оформления заказа напиши в direct (Instagram) \"крутая app-ка\" и получи скидку 15% на текущий и следующий заказы"
    
    //MARK: - Configure
    private func configureBag() {
        let productName = "Комплект: эко-сумка + набор красок, кисти"
        let productImageName = bag.fullBag
        let productDescription = "Цвет: \"\(bag.bagColor)\"\nПринт: \"\(bag.bagImage)\""
        let productPrice = bag.bagColor == "Milk" ? 550 : 600
        let orderedBag = BagModel(productName: productName,
                                  productImageName: productImageName,
                                  productDescription: productDescription,
                                  productPrice: productPrice,
                                  bagColor: bag.bagColor,
                                  colorDescription: bag.colorDescription,
                                  bagImage: bag.bagImage,
                                  imageDescription: bag.imageDescription)
        bag = orderedBag
    }
    //MARK: - Put
    public func put(bag: BagModel) {
        self.bag = bag
    }
    public func putBagToCart() {
        configureBag()
        CartManager.shared.putNewOrder(bag)
    }
    //MARK: - Get
    public func getCleanBagImageName() -> String {
        bag.bagColor
    }
    public func getBagPrintImageName() -> String {
        bag.bagImage
    }
    public func getFullBagImageName() -> String {
        bag.fullBag
    }
    public func getTopLabelText() -> String {
        topLabelText
    }
    public func getDescriptionTitle() -> String {
        descriptionTitle
    }
    public func getDescriptionText() -> String {
        descriptionText
    }
}
