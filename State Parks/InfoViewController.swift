//
//  InfoViewController.swift
//  State Parks
//
//  Created by Watson Li on 10/7/17.
//  Copyright © 2017 Huaxin Li. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var sceneImageView: UIImageView!
    @IBOutlet weak var sceneLabel: UILabel!
    
    var parkName : String?
    var sceneName : String?
    var sceneImage : UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = parkName
        sceneLabel.text = sceneName
        sceneImageView.image = sceneImage
        sceneImageView.contentMode = .scaleAspectFit
        self.view.addSubview(sceneImageView)
    }
    
    func configureInfo(park:String, scene:String, image:UIImage) {
        parkName = park
        sceneName = scene
        sceneImage = image
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return sceneImageView
    }

}
