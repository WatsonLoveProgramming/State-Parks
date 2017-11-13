//
//  ParkModel.swift
//  State Parks
//
//  Created by Watson Li on 9/21/17.
//  Copyright © 2017 Huaxin Li. All rights reserved.
//

import Foundation

struct Park {
    var name: String
    var photos: [Photo]
}

struct Photo {
    var imageName: String
    var caption: String
}

class ParkModel {
    fileprivate let allParks: [Park]
    static let sharedInstance = ParkModel()
    fileprivate let walkThroughImages: [String]
    
    fileprivate init() {
        var _allParks = [Park]()
        let filepath = Bundle.main.path(forResource: "StateParks", ofType: "plist")
        let contents  = NSArray(contentsOfFile: filepath!) as! [[String:Any]]
        for dictionary in contents {
            let photosContent = dictionary["photos"] as! [[String:String]]
            var photos = [Photo]()
            for photo in photosContent {
                let aPhoto = Photo(imageName: photo["imageName"]!, caption: photo["caption"]!)
                photos.append(aPhoto)
            }
            
            let aPark = Park(name: dictionary["name"] as! String, photos: photos)
            _allParks.append(aPark)
        }
        allParks = _allParks
        
        walkThroughImages = ["1","2","3"]
    }
    
    
    var numberOfSections : Int {get {return allParks.count}}
    var numberOfWalkThrough : Int {get {return walkThroughImages.count}}

    func numberOfRows(inSection section:Int) -> Int {
        let park = allParks[section]
        return park.photos.count
    }
    
    func titleFor(section:Int) -> String {
        return allParks[section].name
    }
    
    func imageNameOfPhoto(atIndexPath indexPath:IndexPath) -> String {
        let park = allParks[indexPath.section]
        let photo = park.photos[indexPath.row]
        return photo.imageName
    }
    
    func captionOfPhoto(atIndexPath indexPath:IndexPath) -> String {
        let park = allParks[indexPath.section]
        let photo = park.photos[indexPath.row]
        return photo.caption
    }
    
    func getWalkThroughImages(atIndex index:Int) -> String{
        return walkThroughImages[index]
    }
}
