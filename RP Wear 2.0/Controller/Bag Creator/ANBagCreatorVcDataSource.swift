//
//  ANBagCreatorVcDataSource.swift
//  RP Wear 2.0
//
//  Created by Macbook Pro  on 27.11.2020.
//

import Foundation

struct ColorAndDescription {
    let colorName: String
    let description: String
    var imageName: String { return colorName }
}
class ANBagCreatorVcDataSource: NSObject {
    //MARK: - Properties
    private var bag: BagModel?
    private let colorAndDescriptionArray =
        [ColorAndDescription(colorName: "Red",
                             description: "  Красный - цвет жизни, солнца, огня. Он вызывает противоположные чувства - любовь и ненависть, радость и гнев. Он наиболее бросается в глаза. Красный - цвет сердца, он делает человека разговорчивым, возбуждает и усиливает эмоции."),
         ColorAndDescription(colorName: "Milk",
                             description: "  Бежевый цвет – это классический цвет, который стоит в одном ряду с такими цветами, как белый, серый и черный. Он символизирует тепло, уют, умиротворение, размеренность, гармонию."),
         ColorAndDescription(colorName: "Green",
                             description: "  Зеленый - самый распространенный цвет в нашей европейской природе. Он действует успокаивающе, и поэтому прогулка среди зелени часто бывает необычайно целебна."),
         ColorAndDescription(colorName: "Yellow",
                             description: "  Желтый цвет символизирует полуденное солнце и оказывает стимулирующий эффект. В большей степени он воспринимается левым полушарием мозга, его «интеллектуальной» половиной, и может оказывать положительное влияние на учебу и приобретение профессиональных навыков."),
         ColorAndDescription(colorName: "Blue",
                             description: "  Синий цвет привносит ощущение мира и бесконечности, расслабляет человека. Этот холодный свет влияет на эндокринную систему, на наши реакции на стресс, на релаксацию (расслабление), а также на систему защиты организма от инфекций и аллергии."),
         ColorAndDescription(colorName: "Orange",
                             description: "  Оранжевый цвет олицетворяет радость и счастье. Он благотворно влияет на человека, который страдает от депрессии или склонен к излишнему пессимизму. У людей, которые утром просыпаются уже усталыми, недовольными и слова не вымолвят, пока не выпьют чашку кофе, совершенно меняется настроение, стоит им хотя бы на несколько минут после пробуждения посмотреть на мир сквозь оранжевое стекло.")]
    //MARK: - Methods
    public func getNumberOfImages() -> Int {
        colorAndDescriptionArray.count
    }
    public func getImageName(at index: Int) -> String {
        item(at: index)?.imageName ?? ""
    }
    public func getImageDescription(at index: Int) -> String {
        item(at: index)?.description ?? ""
    }
    public func getBag() -> BagModel {
        if let bag = bag { return bag }
        else { return BagModel() }
    }
    public func createBag(at index: Int) {
        bag = BagModel(bagColor: item(at: index)?.colorName ?? "",
                       colorDescription: item(at: index)?.description ?? "",
                       bagImage: "", imageDescription: "")
    }
    private func item(at index: Int) -> ColorAndDescription? {
        colorAndDescriptionArray.count > index ? colorAndDescriptionArray[index] : nil
    }
}
