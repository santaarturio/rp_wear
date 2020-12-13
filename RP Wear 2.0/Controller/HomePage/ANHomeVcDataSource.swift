//
//  ANHomeVcDataSource.swift
//  RP Wear 2.0
//
//  Created by Macbook Pro  on 30.11.2020.
//

import UIKit

class ANHomeVcDataSource: NSObject {
    //MARK: - Properties
    //MARK:  Top Video name and type
    private let topVideoName = "vika"
    private let topVideoType = "MOV"
    
    //MARK:  instaURL String
    private let instaUrlString = "https://www.instagram.com/really_pretty_wear/"
    
    //MARK:  Text for Labels
    private let brandDescription = "– новый украинский бренд"
    private let quote = "Как говорят наши довольные покупатели: \"Это лучше, чем картины по номерам!\""
    private let brandTarget = "Наша цель - дать возможность каждому воплотить свои самые смелые творческие мечты, тем самым, чуточку помогая нашей планете 🌎"
    private let whatInsideTitle = "В наборе Вы найдете:"
    private let whatInsideText = """
    ✨ Экосумку с готовым контуром
    ✨ Набор премиальных красок по ткани
    ✨ Кисти для рисования
    ✨ Интересную инструкцию
    💥 Приятный бонус*
    """
    private let howToDrawTitle = "Как рисовать"
    private let howToDrawText = """
    ✨ Готовый контур на сумке поможет не нарисовать лишнего
    ✨ Инструкция с примером готового рисунка станет Вашим путеводителем в этом увлекательном процессе
    💥 ВАЖНО! Не забудьте сделать небольшой перерыв на *внимательный осмотр бонуса
    """
    private let reviews = "Отзывы"
    
    private var allTextArray: [String] {
        return [brandDescription, quote, brandTarget, whatInsideTitle, whatInsideText, howToDrawTitle, howToDrawText, reviews]
    }
    //MARK: - Methods
    public func getVideoURL() -> URL? {
        if let path = Bundle.main.path(forResource: topVideoName, ofType: topVideoType) { return URL(fileURLWithPath: path) }
        else { return nil }
    }
    public func getInstaURL() -> URL? {
        URL(string: instaUrlString)
    }
    public func getLabelText(at index: Int) -> String {
        allTextArray.count > index ? allTextArray[index] : "invalid index"
    }
}
