//
//  RootViewController.swift
//  State Parks
//
//  Created by Watson Li on 10/8/17.
//  Copyright © 2017 Huaxin Li. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var pageViewController : UIPageViewController?
    let parkModel = ParkModel.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()

        pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageViewController") as? UIPageViewController
        
        pageViewController?.dataSource = self
        pageViewController?.delegate = self
        
        // add first page
        let firstPage = viewController(atIndex: 0)
        pageViewController?.setViewControllers([firstPage], direction: .forward, animated: false, completion: nil)

        
        
        //add pageView Controller to root view
        pageViewController!.view.frame = self.view.bounds
        self.view.addSubview(pageViewController!.view)
        
        self.addChildViewController(pageViewController!)
        pageViewController!.didMove(toParentViewController: self)
    }

    //MARK: - UIPageViewController Data Source
    
    func viewController(atIndex index:Int) -> UIViewController {
        let contentViewController = storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        
        let imageName = parkModel.getWalkThroughImages(atIndex: index)
        contentViewController.configure(image: imageName)
        contentViewController.walkThroughIndex = index
        
        return contentViewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let contentViewController = viewController as! ContentViewController
        let currentIndex = contentViewController.walkThroughIndex!
        
        guard currentIndex < parkModel.numberOfWalkThrough-1 else {return nil}
        let newViewController = self.viewController(atIndex: currentIndex+1)
        return newViewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let contentViewController = viewController as! ContentViewController
        let currentIndex = contentViewController.walkThroughIndex!
        
        guard currentIndex > 0 else {return nil}
        let newViewController = self.viewController(atIndex: currentIndex-1)
        return newViewController
    }

}
