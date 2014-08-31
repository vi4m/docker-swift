//
//  ImagesTableViewController.swift
//  DockerClient
//
//  Created by Andrew Weiss on 7/27/14.
//  Copyright (c) 2014 Andrew Weiss. All rights reserved.
//

import UIKit

class ImagesTableViewController: UITableViewController {
    @IBOutlet weak var slideMenuBarButtonItem: UIBarButtonItem!
    
    var dockerHostUrl: String?
    var images = [DockerImage]()
    
    override func viewDidLoad () {
        super.viewDidLoad()
        updateUI()
        
        if let url = dockerHostUrl {
            DockerClient.connection.getImages(url, port: 4243, completionBlock: imagesReceived)
        }
    }

    func imagesReceived(err: NSErrorPointer, images: [DockerImage]) -> Void {
        self.images = images
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        // return self.images.count
        return 1
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell: ImagesTableViewCell = tableView.dequeueReusableCellWithIdentifier("imageCellIdentifier", forIndexPath: indexPath) as ImagesTableViewCell
        
        // var repoTags = self.images[indexPath.row].repoTags
        // cell.nameLabel.text = repoTags![0]
        cell.nameLabel.text = "Testing"
        return cell
    }
    
    override func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        tableView.separatorColor = UIColor.whiteColor()
        return 170
    }

    func updateUI() -> Void {
        self.navigationController.navigationBar.barTintColor = UIColor(red: 0.165, green: 0.169, blue: 0.231, alpha: 1)
        self.navigationController.navigationBar.translucent = false
        for view in self.navigationController.navigationBar.subviews {
            for view2 in view.subviews {
                if let subView = view2 as? UIImageView {
                    if subView.frame.size.height < 2 {
                        subView.removeFromSuperview()
                    }
                }
            }
        }
        
        
        if let rvc: SWRevealViewController = self.revealViewController() {
            rvc.toggleAnimationDuration = 0.16
            rvc.toggleAnimationType = SWRevealToggleAnimationType.EaseOut
            self.slideMenuBarButtonItem.target = self.revealViewController()
            self.slideMenuBarButtonItem.action = "revealToggle:"
            self.navigationController.navigationBar.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        self.tableView.backgroundColor = UIColor(red: 0.165, green: 0.169, blue: 0.231, alpha: 1)
        self.tableView.registerNib(UINib(nibName: "ImagesTableViewCell", bundle: nil), forCellReuseIdentifier: "imageCellIdentifier")
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        self.performSegueWithIdentifier("imageDetailSegue", sender: indexPath)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if let dvc = segue.destinationViewController as? ImageDetailViewController {
            if let indexPath = sender as? NSIndexPath {
                // dvc.image = self.images[indexPath.row]
                dvc.image = DockerImage()
            }
        }
    }

}
