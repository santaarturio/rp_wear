//
//  ANImageBagCreatorVcDataSource.swift
//  RP Wear 2.0
//
//  Created by Macbook Pro  on 30.11.2020.
//

import UIKit

struct ImageAndDescription {
    let imageName: String
    let description: String
}
class ANImageBagCreatorVcDataSource: NSObject {
    //MARK: - Properties
    private var bag = BagModel()
    private let imageAndDescriptionArray =
        [ImageAndDescription(imageName: "Groot",
                             description: "this is groot"),
         ImageAndDescription(imageName: "Lisa",
                             description: "this is losa"),
         ImageAndDescription(imageName: "Dog",
                             description: "this is a dog"),
         ImageAndDescription(imageName: "Duck",
                             description: "this is a duck"),
         ImageAndDescription(imageName: "Stich",
                             description: "this is stich"),
         ImageAndDescription(imageName: "IronMan",
                             description: "this is ironMan"),
         ImageAndDescription(imageName: "Guffie",
                             description: "this is guffie"),
         ImageAndDescription(imageName: "Abstraction",
                             description: "this is abstraction"),
         ImageAndDescription(imageName: "Sun",
                             description: "this is sun"),
         ImageAndDescription(imageName: "Cat",
                             description: "this is cat"),
         ImageAndDescription(imageName: "Fox",
                             description: "this is fox"),
         ImageAndDescription(imageName: "Couple",
                             description: "this is couple"),
         ImageAndDescription(imageName: "Brain",
                             description: "this is brain")]
    //MARK: - Public methods
    //MARK: Put
    public func put(bag: BagModel) {
        self.bag = bag
    }
    //MARK: Get
    public func getBag() -> BagModel {
        bag
    }
    public func getNumberOfImages() -> Int {
        imageAndDescriptionArray.count
    }
    public func getImageName(at index: Int) -> String {
        item(at: index)?.imageName ?? ""
    }
    public func getImageDescription(at index: Int) -> String {
        item(at: index)?.description ?? ""
    }
    //MARK: Configure
    public func configureBag(at index: Int) {
        bag.bagImage = getImageName(at: index)
        bag.imageDescription = getImageDescription(at: index)
        bag.productImageName = bag.fullBag
    }
    //MARK: - Private methods
    private func item(at index: Int) -> ImageAndDescription? {
        imageAndDescriptionArray.count > index ? imageAndDescriptionArray[index] : nil
    }
}
