//
//  ParkTableViewController.swift
//  State Parks
//
//  Created by Watson Li on 9/30/17.
//  Copyright © 2017 Huaxin Li. All rights reserved.
//

import UIKit

class ParkTableViewController: UITableViewController {
    
    let parkModel = ParkModel.sharedInstance
    var imageView = UIImageView()
    let imageScrollView = UIScrollView()
    var sectionCollapse = [Bool]()  //a boolean array to keep track of which section is collapse
    var walkThrough = true

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName:"ParkTableHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier:"CustomHeaderView")
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.white
        self.navigationItem.title = "State Parks"
        
        
        for _ in 0..<parkModel.numberOfSections{
            sectionCollapse.append(false)
        }
        
        self.splitViewController?.preferredDisplayMode = .allVisible
    }

    //switch to walk through when the app first runs
    override func viewWillAppear(_ animated: Bool) {
        if walkThrough{
            performSegue(withIdentifier: "PageSegue", sender: self)
        }
        walkThrough = false
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return parkModel.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionCollapse[section] ? 0 : parkModel.numberOfRows(inSection: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! ParkTableViewCell
        
        // Configure the cell
        cell.parkLabel!.text = parkModel.captionOfPhoto(atIndexPath: indexPath)
        let imageName = parkModel.imageNameOfPhoto(atIndexPath: indexPath)
        let image = UIImage(named: imageName)
        cell.parkImageView.image = image
        
        return cell
    }

    //function to configure the section header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomHeaderView") as! ParkTableHeaderView
        headerView.sectionTitle.setTitle(parkModel.titleFor(section: section), for: .normal)
        headerView.sectionTitle.tag = section
        headerView.sectionTitle.addTarget(self, action: #selector(ParkTableViewController.toggleSection(sender:)), for: .touchUpInside)
        headerView.contentView.backgroundColor = UIColor.orange
        return headerView
    }
    
    //toggle section when the header is clicked
    func toggleSection(sender: UIButton){
        sectionCollapse[sender.tag] = !sectionCollapse[sender.tag]
        tableView.reloadSections(IndexSet(integer: sender.tag), with: .automatic)
    }
    
    
    //MARK: - ScrollView Delegate
    
    override func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }    
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var infoViewController : InfoViewController?
        
        switch segue.identifier! {
        case "SplitViewInfoSegue":
            let navController = segue.destination as! UINavigationController
            infoViewController = navController.topViewController as? InfoViewController
            
            // It's nil if didn't fall through
            if infoViewController == nil {
                infoViewController = segue.destination as? InfoViewController
            }
            
            let indexPath = tableView.indexPathForSelectedRow!
            let park = parkModel.titleFor(section: indexPath.section)
            let scene = parkModel.captionOfPhoto(atIndexPath: indexPath)
            let imageName = parkModel.imageNameOfPhoto(atIndexPath: indexPath)
            let image = UIImage(named: imageName)!
            
            infoViewController?.configureInfo(park: park, scene: scene, image: image)
            
            // set display mode button if we're in a splitview
            if splitViewController != nil {
                infoViewController?.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                infoViewController?.navigationItem.leftItemsSupplementBackButton = true
            }
        
        case "PageSegue":
            break
            
        default:
            assert(false, "Unhandled Segue")
        }

    }
}
