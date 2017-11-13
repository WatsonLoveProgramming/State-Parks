//
//  ContentViewController.swift
//  State Parks
//
//  Created by Watson Li on 10/8/17.
//  Copyright © 2017 Huaxin Li. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let parkModel = ParkModel.sharedInstance
    var walkThroughIndex : Int?
    var imageName : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurePageControl()
        imageView.image = UIImage(named: imageName!)
        goButton.isHidden = (walkThroughIndex == 2) ? false : true
    }
    
    func configure(image name:String) {
        imageName = name
    }
    
    func configurePageControl() {
        pageControl.numberOfPages = parkModel.numberOfWalkThrough
        pageControl.currentPage = walkThroughIndex!
    }
    
    @IBAction func dismissMe(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
