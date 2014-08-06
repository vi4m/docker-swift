//
//  ImagesTableViewController.swift
//  DockerClient
//
//  Created by Andrew Weiss on 7/27/14.
//  Copyright (c) 2014 Andrew Weiss. All rights reserved.
//

import UIKit

class ImagesTableViewController: UITableViewController {
    var images = [DockerImage]()
    
    override func viewDidLoad () {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor(red: 0.165, green: 0.169, blue: 0.231, alpha: 1)
        self.tableView.registerNib(UINib(nibName: "ImagesTableViewCell", bundle: nil), forCellReuseIdentifier: "imageCellIdentifier")
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        DockerClient.connection.getImages(Constants.URL, port: 4243, completionBlock: dataReceived)
    }

    func dataReceived(err: NSErrorPointer, responseArray: [DockerImage]) -> Void {
        self.images = responseArray
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
        return self.images.count
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell: ImagesTableViewCell = tableView.dequeueReusableCellWithIdentifier("imageCellIdentifier", forIndexPath: indexPath) as ImagesTableViewCell!
        
        var repoTags = self.images[indexPath.row].repoTags
        cell.nameLabel.text = repoTags![0]
        return cell
    }
    
    override func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        tableView.separatorColor = UIColor.whiteColor()
        return 175
    }
    @IBAction func slideMenuBarButtonItem(sender: UIBarButtonItem) {
        self.navigationController.popViewControllerAnimated(true)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
