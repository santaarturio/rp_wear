//
//  QuizManager.swift
//  RP Wear 2.0
//
//  Created by Macbook Pro  on 03.12.2020.
//

import Foundation

class QuizManager {
    private let colorsArray = [["Yellow", "Orange", "Red"], ["Milk", "Blue", "Green"]]
    private let imagesArray = [["Lisa", "Stich", "Groot", "IronMan", "Guffie"],
                              ["Abstraction", "Sun"],
                              ["Dog", "Duck", "Cat", "Fox", "Couple", "Brain"]]
    public func getResult(answers: [Int]) -> BagModel {
        let colorName = colorsArray[answers[0]][answers[1]]
        var imageName = ""
        
        switch answers[4] {
        case 0...4: imageName = imagesArray[0][answers[4]]
        case 5:
            let choosenArray = imagesArray[answers[3]]
            let halfOfArray = choosenArray.count / 2
            let randomLite = Int.random(in: 0..<halfOfArray)
            let randomHard = Int.random(in: halfOfArray..<choosenArray.count)
            
            if answers[5] == 0 { imageName = choosenArray[randomLite]
            } else { imageName = choosenArray[randomHard] }
        default: break
        }
        return BagModel(bagColor: colorName, colorDescription: "",
                        bagImage: imageName, imageDescription: "")
    }
}
